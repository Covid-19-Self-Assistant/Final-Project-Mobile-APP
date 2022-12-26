import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/profile_page/PickImageFromGalleryOrCamera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Connection> connections = [];
  bool isProfileLoading = false;
  final picker = ImagePicker();
  bool isImagesPicked = false;
  bool covidStatus = false;
  String profileImage = "";
  String userName = "";

  String? documentName = "";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final users = FirebaseFirestore.instance.collection('users');
  final storageReference = FirebaseStorage.instance.ref().child('images');

  Future getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      documentName = prefs.getString("email");
    });
    try {
      setState(() {
        isProfileLoading = true;
      });
      DocumentSnapshot<Map<String, dynamic>> status =
          await users.doc(documentName).get();
      Map<String, dynamic>? data = status.data();
      setState(() {
        isProfileLoading = false;
      });
      print(data);
      if (data != null) {
        setState(() {
          userName = '${data['firstName']} ${data['lastName']}';
          covidStatus = data['covidStatus'] as bool;
          profileImage = data['profileImage'];
        });
      }
    } catch (e) {
      setState(() {
        isProfileLoading = false;
      });
      // ignore: todo
      // TODO: error handling
    }
  }

  Future saveImage(context) async {
    try {
      XFile? _image =
          await PickImageFromGalleryOrCamera.getProfileImage(context, picker);

      if (_image!.path != "") {
        try {
          setState(() {
            isProfileLoading = true;
          });
          await storageReference.putFile(File(_image!.path));
          String imageUrl = await storageReference.getDownloadURL();
          await users.doc(documentName).update({"profileImage": imageUrl});
          setState(() {
            isImagesPicked = false;
            profileImage = imageUrl;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Successfully upload the profile picture."),
          ));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Not uploaded the profile picture"),
          ));
        }
      } else {
        print('No image');
      }

      setState(() {
        isProfileLoading = false;
      });
    } catch (e) {
      setState(() {
        isProfileLoading = false;
      });
    }
  }

  Color getCovidColorCode() {
    return covidStatus == true ? Colors.red : Colors.green;
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              children: [
                SizedBox(height: 20),
                Container(
                    width: 200,
                    height: 200,
                    child: isProfileLoading
                        ? CircularProgressIndicator()
                        : profileImage.isEmpty
                            ? CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  profileImage,
                                ),
                              )),
                MaterialButton(
                  onPressed: () => saveImage(context),
                  child: Icon(Icons.cloud_upload),
                ),
                SizedBox(height: 20),
                Text(
                  userName.toString(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.coronavirus,
                  color: getCovidColorCode(),
                ),
                Text(
                  "covid status",
                  style: TextStyle(
                    color: getCovidColorCode(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final Future<SharedPreferences> _prefs =
                        SharedPreferences.getInstance();
                    final SharedPreferences prefs = await _prefs;
                    prefs.remove("isLogin");
                    prefs.remove("email");
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                profileSections("Edit page", ''),
                profileSections("Connection Details", 'connectivityDetails'),
              ],
            );
          },
        ),
      ),
    );
  }

  Card profileSections(String title, String path) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.blue[900],
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () {
            if (path.isNotEmpty) Navigator.pushNamed(context, '/$path');
          },
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Connection {
  String day;
  String user;
  String email;
  bool selectedStatus;
  Connection(
      {this.day = "",
      required this.email,
      required this.user,
      required this.selectedStatus});
}

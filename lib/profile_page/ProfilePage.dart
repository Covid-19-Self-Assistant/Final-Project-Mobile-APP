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

  // TODO: get the user from the firestore
  String? dummyName = "";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final users = FirebaseFirestore.instance.collection('users');
  final storageReference = FirebaseStorage.instance.ref().child('images');

  Future getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      dummyName = prefs.getString("email");
    });
    try {
      setState(() {
        isProfileLoading = true;
      });
      DocumentSnapshot<Map<String, dynamic>> status =
          await users.doc(dummyName).get();
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
      // TODO: error handling
    }
  }

  // TODO: get the profile details from the api

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
          await users.doc(dummyName).update({"profileImage": imageUrl});
          setState(() {
            isImagesPicked = false;
            profileImage = imageUrl;
          });
        } catch (e) {
          print(e);
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
    print(userName);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
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
                MaterialButton(
                  onPressed: () async {
                    final Future<SharedPreferences> _prefs =
                        SharedPreferences.getInstance();
                    final SharedPreferences prefs = await _prefs;
                    prefs.remove("isLogin");
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Log out"),
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
      color: Color.fromARGB(255, 179, 222, 243),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        trailing: IconButton(
          onPressed: () {
            if (path.isNotEmpty) Navigator.pushNamed(context, '/$path');
          },
          icon: Icon(Icons.arrow_forward),
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

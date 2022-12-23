import 'dart:io';

import 'package:dating_app/profile_page/PickImageFromGalleryOrCamera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Connection> connections = [
    Connection(day: "2022-12-20"),
    Connection(day: "2022-12-21"),
    Connection(day: "2022-12-22"),
    Connection(day: "2022-12-23"),
    Connection(day: "2022-12-24"),
  ];
  bool profileLoading = false;
  final picker = ImagePicker();
  late XFile? pickedFile;
  bool isImagesPicked = false;

  // TODO: get the profile details from the api

  Future saveImage(context) async {
    try {
      XFile? _image =
          await PickImageFromGalleryOrCamera.getProfileImage(context, picker);

      if (_image!.path != "") {
        setState(() {
          isImagesPicked = true;
          profileLoading = true;
          pickedFile = _image;
        });
      } else {
        print('No image');
      }

      setState(() {
        profileLoading = false;
      });
    } catch (e) {
      setState(() {
        profileLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              children: [
                SizedBox(height: 20),
                Container(
                    height: 200,
                    width: 200,
                    child: isImagesPicked == false
                        ? CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/doctor.png'),
                          )
                        : Container(
                            child: Image.file(File(pickedFile!.path)),
                          )),
                SizedBox(height: 20),
                Text(
                  'Angela Yu',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () => saveImage(context),
                  child: Icon(Icons.cloud_upload),
                ),
                SizedBox(height: 10),
                Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
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
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/connectivityDetails");
                    },
                    color: Colors.blue,
                    child: Text(
                      'Connectivity Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Connection {
  final String day;
  Connection({required this.day});
}

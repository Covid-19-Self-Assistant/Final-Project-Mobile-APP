import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _form = GlobalKey<FormState>();
  User user = User();
  bool isLoading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String? documentName;
  final users = FirebaseFirestore.instance.collection('users');

  Future getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      documentName = prefs.getString("email");
    });
    try {
      setState(() {
        isLoading = true;
      });
      DocumentSnapshot<Map<String, dynamic>> status =
          await users.doc(documentName).get();
      Map<String, dynamic>? data = status.data();
      setState(() {
        isLoading = false;
      });
      print(data);
      if (data != null) {
        setState(() {
          user.firstName = data['firstName'];
          user.lastName = data['lastName'];
          user.birthDay = data['birthDay'];
          user.deviceInfo = data['device'];
          user.mobile = data['mobile'];
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveUser() async {
    _form.currentState!.save();
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final SharedPreferences prefs = await _prefs;

      setState(() {
        documentName = prefs.getString("email");
      });
      var data = {
        "firstName": user.firstName,
        "lastName": user.lastName,
        "mobile": user.mobile,
        "device": user.deviceInfo,
        "birthDay": user.birthDay
      };
      await users.doc(documentName).update(data);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Successfully updated the user details."),
          ));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong. Please try again"),
          ));
      setState(() {
        isLoading = false;
      });
    }
  }

  void _getDeviceInformations() async {
    String? address = await FlutterBluetoothSerial.instance.address;

    setState(() {
      if (address != null) {
        user.deviceInfo = address;
      }
      ;
    });
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
        backgroundColor: Colors.blue[900],
        title: Text('User Details'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          user.firstName = value;
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'First Name is required';
                          }
                          return null;
                        },
                        initialValue: user.firstName,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          user.lastName = value;
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                        initialValue: user.lastName,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          user.mobile = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Mobile number is required';
                          }
                          if (value.length != 10) {
                            return 'Invalid Mobile number';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        initialValue: user.mobile,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          user.birthDay = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Birth date is required';
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        initialValue: user.birthDay,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Birth Date',
                        ),
                      ),
                      SizedBox(height: 15.0),
                      MaterialButton(
                        onPressed: _getDeviceInformations,
                        child: Text(
                          'Device Infor',
                          textAlign: TextAlign.start,
                        ),
                      ),
                      if (user.deviceInfo != null)
                        Container(
                          child: Text(
                              user.deviceInfo != null ? user.deviceInfo! : ""),
                        ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: MaterialButton(
                          onPressed: saveUser,
                          color: Colors.blue[900],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class User {
  String? firstName;
  String? lastName;
  String? deviceInfo;
  String? birthDay;
  String? mobile;

  User({
    this.firstName,
    this.lastName,
    this.deviceInfo,
    this.mobile,
    this.birthDay,
  });
}

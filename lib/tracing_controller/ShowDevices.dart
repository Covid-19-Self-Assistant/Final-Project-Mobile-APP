import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDevices extends StatefulWidget {
  @override
  _ShowDevicesState createState() => _ShowDevicesState();
}

class _ShowDevicesState extends State<ShowDevices> {
  // Initialize a list to store the Bluetooth devices
  Set<String> _devices = Set();
  bool isDiscovering = false;
  List<ConnectedUser> connectedUsers = [];

  String? documentName = "";
  final users = FirebaseFirestore.instance.collection('users');

  final connections = FirebaseFirestore.instance.collection('connections');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isSyncing = false;
  bool isScanning = false;
  int sycingNumber = 0;

  Future syncWithUser(String email, String userName, int index) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      documentName = prefs.getString("email");
    });

    try {
      var date = DateTime.now();
      setState(() {
        isSyncing = true;
        sycingNumber = index;
      });

      await connections.doc(documentName).set({
        'details': FieldValue.arrayUnion(
          [
            {
              "date": '${date.year}-${date.month}-${date.day}',
              "email": email,
              "name": userName
            },
          ],
        ),
      }, SetOptions(merge: true));

      setState(() {
        isSyncing = false;
        sycingNumber = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Successfully sync with the user."),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unable to sync with the user. Please try again"),
      ));
      setState(() {
        isSyncing = false;
        sycingNumber = 0;
      });
    }
  }

  var type = false;
  Stream<BluetoothDiscoveryResult> stream =
      FlutterBluetoothSerial.instance.startDiscovery();

  void _startScan() {
    _devices.clear();

    try {
      setState(() {
        isScanning = true;
      });
      stream.listen((value) {
        // Update the list of Bluetooth map
        _devices.add(value.device.address);
        setState(() {
          isScanning = false;
        });
      });
    } catch (e) {
      setState(() {
        isScanning = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unable to scanning at the movement. Please try again"),
      ));
    }
  }

  Future<void> startDiscovering() async {
    try {
      setState(() {
        isDiscovering = true;
      });
      _devices.add(" ");
      QuerySnapshot<Map<String, dynamic>> matchedUsers =
          await users.where("device", whereIn: _devices.toList()).get();
      setState(() {
        isDiscovering = false;
      });
      final SharedPreferences prefs = await _prefs;

      for (var i = 0; i < matchedUsers.docs.length - 1; i++) {
        var user = matchedUsers.docs[i].data();

        int index = connectedUsers
            .indexWhere((element) => element.email == user['email']);

        var myEmail = prefs.getString("email");
        if (myEmail == user['email']) {
          continue;
        }

        if (index == -1) {
          connectedUsers.add(ConnectedUser(
              email: user['email'],
              firstName: user['firstName'],
              profileImage: user['profileImage']));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong. $e'),
      ));
      setState(() {
        isDiscovering = false;
      });
    }
  }

  cancelLoading() {
    setState(() {
      isScanning = false;
    });
  }

  @override
  void initState() {
    _startScan();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: cancelLoading,
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          'Covid 19 Self Assistance',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: isScanning
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      bottom: 10.0,
                      top: 30.0,
                    ),
                    child: Container(
                      height: 100.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 4.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image(
                              image: AssetImage('assets/images/corona.png'),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Your Contact Traces',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    onPressed: startDiscovering,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "START TRACING",
                        ),
                        Icon(
                          Icons.cloud_sync_sharp,
                          size: 50,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                if (isDiscovering) CircularProgressIndicator(),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: ListView.builder(
                      itemCount: connectedUsers.toList().length,
                      itemBuilder: ((context, index) {
                        return Center(
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: connectedUsers
                                            .toList()[index]
                                            .profileImage ==
                                        ""
                                    ? Text(connectedUsers
                                        .toList()[index]
                                        .firstName[0])
                                    : null,
                                backgroundImage: connectedUsers
                                            .toList()[index]
                                            .profileImage !=
                                        ""
                                    ? NetworkImage(connectedUsers
                                        .toList()[index]
                                        .profileImage)
                                    : null,
                              ),
                              title: Text(
                                  connectedUsers.toList()[index].firstName),
                              trailing: IconButton(
                                icon: isSyncing && sycingNumber == index
                                    ? CircularProgressIndicator()
                                    : Icon(Icons.sync),
                                onPressed: () {
                                  syncWithUser(
                                      connectedUsers.toList()[index].email,
                                      connectedUsers.toList()[index].firstName,
                                      index);
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ConnectedUser {
  String firstName;
  String email;
  String profileImage;

  ConnectedUser(
      {required this.firstName,
      required this.profileImage,
      required this.email});
}

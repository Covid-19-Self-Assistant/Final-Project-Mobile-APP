import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/components/constants.dart';
import 'package:dating_app/details_pages/details_screen.dart';
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
      print(e);
      setState(() {
        isSyncing = false;
        sycingNumber = 0;
      });
    }
  }

  var type = false;

  Future<void> _startScan() async {
    _devices.clear();

    try {
      FlutterBluetoothSerial.instance.startDiscovery().listen((value) async {
        // Update the list of Bluetooth map
        _devices.add(value.device.address);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> startDiscovering() async {
    try {
      setState(() {
        isDiscovering = true;
      });
      QuerySnapshot<Map<String, dynamic>> matchedUsers =
          await users.where("device", whereIn: _devices.toList()).get();
      setState(() {
        isDiscovering = false;
      });
      for (var i = 0; i < matchedUsers.docs.length; i++) {
        var user = matchedUsers.docs[i].data();
        int index = connectedUsers
            .indexWhere((element) => element.email == user['email']);
        if (index == -1) {
          connectedUsers.add(ConnectedUser(
              email: user['email'],
              firstName: user['firstName'],
              profileImage: user['profileImage']));
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        isDiscovering = false;
      });
    }
  }

  @override
  void initState() {
    _startScan();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.deepPurple,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DetailsPage()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Covid 19 Self Assistance',
          style: TextStyle(
            color: Colors.deepPurple[800],
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
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
                  color: Colors.deepPurple[500],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
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
                            backgroundImage: NetworkImage(
                                connectedUsers.toList()[index].profileImage)),
                        title: Text(connectedUsers.toList()[index].firstName),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/components/constants.dart';
import 'package:dating_app/details_pages/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import '../components/contact_card.dart';

class NearbyInterface extends StatefulWidget {
  static const String id = 'nearby_interface';

  @override
  _NearbyInterfaceState createState() => _NearbyInterfaceState();
}

class _NearbyInterfaceState extends State<NearbyInterface> {
  Location location = Location();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Strategy strategy = Strategy.P2P_STAR;
  late User loggedInUser;
  String testText = '';
  final _auth = FirebaseAuth.instance;
  List<dynamic> contactTraces = [];
  List<dynamic> contactTimes = [];
  List<dynamic> contactLocations = [];

  void addContactsToList() async {
    await getCurrentUser();

    _firestore
        .collection('users')
        .doc(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        // String currUsername = doc.data['username'];
        String currUsername = doc['username'].data();

        DateTime? currTime = doc.data().containsKey('contact time')
            ? (doc.data()['contact time'] as Timestamp).toDate()
            : null;
        String currLocation = doc.data().containsKey('contact location')
            ? doc.data()['contact location']
            : null;

        if (!contactTraces.contains(currUsername)) {
          contactTraces.add(currUsername);
          contactTimes.add(currTime);
          contactLocations.add(currLocation);
        }
      }
      setState(() {});
      print(loggedInUser.email);
    });
  }

  void deleteOldContacts(int threshold) async {
    await getCurrentUser();
    DateTime timeNow = DateTime.now(); //get today's time

    _firestore
        .collection('users')
        .doc(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
//        print(doc.data.containsKey('contact time'));
        if (doc.data().containsKey('contact time')) {
          DateTime contactTime = (doc.data()['contact time'] as Timestamp)
              .toDate(); // get last contact time
          // if time since contact is greater than threshold than remove the contact
          if (timeNow.difference(contactTime).inDays > threshold) {
            doc.reference.delete();
          }
        }
      }
    });

    setState(() {});
  }

  void discovery() async {
    try {
      bool a = await Nearby()
          .startDiscovery(loggedInUser.email.toString(), strategy,
              onEndpointFound: (id, name, serviceId) async {
        print('I saw id:$id with name:$name'); // the name here is an email

        var docRef = _firestore.collection('users').doc(loggedInUser.email);

        //  When I discover someone I will see their email and add that email to the database of my contacts
        //  also get the current time & location and add it to the database
        docRef.collection('met_with').doc(name).set({
          'username': await getUsernameOfEmail(email: name),
          'contact time': DateTime.now(),
          'contact location': (await location.getLocation()).toString(),
        });
      }, onEndpointLost: (id) {
        print(id);
      });
      print('DISCOVERING: ${a.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void getPermissions() {
    Nearby().askLocationAndExternalStoragePermission();
  }

  Future<String> getUsernameOfEmail({String? email}) async {
    String res = '';
    await _firestore.collection('users').doc(email).get().then((doc) {
      if (doc.exists) {
        res = doc.data()!['username'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return res;
  }
  // currentUser()

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.authStateChanges().listen((User? user) {
        if (user != null) {
          loggedInUser = user;
        }
      });
    } catch (e) {
      print(e);
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    deleteOldContacts(14);
    addContactsToList();
    getPermissions();
  }

  @override
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
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                try {
                  bool a = await Nearby().startAdvertising(
                    loggedInUser.email.toString(),
                    strategy,
                    onConnectionInitiated: (type, ctx) {},
                    onConnectionResult: (id, status) {
                      print(status);
                    },
                    onDisconnected: (id) {
                      print('Disconnected $id');
                    },
                  );

                  print('ADVERTISING ${a.toString()}');
                } catch (e) {
                  print(e);
                }

                discovery();
              },
              child: Text(
                'Start Tracing',
                style: kButtonTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ContactCard(
                    imagePath: 'assets/images/profile1.jpg',
                    email: contactTraces[index],
                    infection: 'Not-Infected',
                    contactUsername: contactTraces[index],
                    contactTime: contactTimes[index],
                    contactLocation: contactLocations[index],
                  );
                },
                itemCount: contactTraces.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  RaisedButton(
      {required RoundedRectangleBorder shape,
      required double elevation,
      required Color color,
      required Future<Null> Function() onPressed,
      required Text child}) {}
}

@override
Widget build(Object context) {
  // TODO: implement build
  throw UnimplementedError();
}
  
  

// TODO: Take mobile number instead of email

// TODO: Delete contacts older than 14 days from database

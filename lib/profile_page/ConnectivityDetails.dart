import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/profile_page/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectivityDetails extends StatefulWidget {
  const ConnectivityDetails({super.key});

  @override
  State<ConnectivityDetails> createState() => _ConnectivityDetailsState();
}

class _ConnectivityDetailsState extends State<ConnectivityDetails> {
  List<Connection> connections = [];
  List<Connection> newConnections = [];

  late List<Connection> allConnections;

  bool type = false;

  String? documentName = "";
  final users = FirebaseFirestore.instance.collection('connections');

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future getUserConnections() async {
    try {
      final SharedPreferences prefs = await _prefs;
      setState(() {
        documentName = prefs.getString("email");
      });
      DocumentSnapshot<Map<String, dynamic>> status =
          await users.doc(documentName).get();
      Map<String, dynamic>? data = status.data();
      if (data != null) {
        List details = data['details'];
        for (var i = 0; i < details.length; i++) {
          var detail = details[i];
          connections.add(Connection(
              day: detail['date'],
              user: detail['name'],
              selectedStatus: false,
              email: detail['email']));

          newConnections
              .removeWhere((element) => element.day == detail['date']);
          newConnections.add(Connection(
              day: detail['date'],
              user: detail['name'],
              selectedStatus: false,
              email: detail['email']));
        }
      }

      if (data != null) {
        setState(() {});
      }
    } catch (e) {
      // TODO: error handling
    }
  }

  void _searchByDate() async {
    DateTime? pickeddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    );

    if (pickeddate != null) {
      var year = pickeddate.year;
      var month = pickeddate.month;
      var day = pickeddate.day;
      var date = '$year-$month-$day';
      setState(() {
        List<Connection> searchedConnections =
            newConnections.where((element) => element.day == date).toList();

        newConnections = searchedConnections;
      });
    }
  }

  @override
  void initState() {
    getUserConnections();
    allConnections = newConnections;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          setState(() {
            newConnections = allConnections;
          });
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "Search by date",
        ),
        actions: [
          MaterialButton(
              onPressed: _searchByDate,
              child: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          // days list
          ...newConnections.map(
            ((con) {
              String date = con.day.toString();
              List<Connection> filteredConnections =
                  connections.where((element) => element.day == date).toList();

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/usersList',
                      arguments: filteredConnections);
                },
                child: Card(
                  child: ListTile(
                    title: Text(date),
                  ),
                ),
              );
            }),
          ).toList(),
        ],
      ),
    );
  }
}

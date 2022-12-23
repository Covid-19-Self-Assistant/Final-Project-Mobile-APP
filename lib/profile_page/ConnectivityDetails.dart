import 'package:dating_app/profile_page/ProfilePage.dart';
import 'package:flutter/material.dart';

class ConnectivityDetails extends StatefulWidget {
  const ConnectivityDetails({super.key});

  @override
  State<ConnectivityDetails> createState() => _ConnectivityDetailsState();
}

class _ConnectivityDetailsState extends State<ConnectivityDetails> {
  List<Connection> connections = [
    Connection(day: "2022-12-20"),
    Connection(day: "2022-12-21"),
    Connection(day: "2022-12-22"),
    Connection(day: "2022-12-23"),
    Connection(day: "2022-12-24"),
  ];

  late List<Connection> allConnections;

  bool type = false;

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
            connections.where((element) => element.day == date).toList();

        connections = searchedConnections;
      });
    }
  }

  @override
  void initState() {
    allConnections = connections;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            connections = allConnections;
          });
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text("Search by date"),
        actions: [
          MaterialButton(onPressed: _searchByDate, child: Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          // days list
          ...connections
              .map(((e) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/usersList');
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(e.day.toString()),
                      ),
                    ),
                  )))
              .toList(),
        ],
      ),
    );
  }
}

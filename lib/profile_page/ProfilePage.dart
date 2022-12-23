import 'package:flutter/material.dart';
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
  // TODO: get the profile details from the api

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
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/doctor.png',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Angela Yu',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
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
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, bottom: 5),
                  height: 20,
                  width: double.infinity,
                  child: Text(
                    "Connectivity Details",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),

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

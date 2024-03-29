import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map localData = {};
  Map globalData = {};
  bool isGloble = false;
  bool isLocal = true;
  String conform = '';
  String active = '';
  String recovered = '';
  String death = '';
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = getCovid19Details();
  }

  Future getCovid19Details() async {
    try {
      var response = await Dio()
          .get('https://www.hpb.health.gov.lk/api/get-current-statistical');

      var myData = response.data["data"];

      localData = {
        "local_new_cases": myData["local_new_cases"],
        "local_total_cases": myData["local_total_cases"],
        "local_deaths": myData["local_deaths"],
        "local_new_deaths": myData["local_new_deaths"],
        "local_recovered": myData["local_recovered"],
        "local_active_cases": myData["local_active_cases"],
      };

      globalData = {
        "global_new_cases": myData["global_new_cases"],
        "global_total_cases": myData["global_total_cases"],
        "global_deaths": myData["global_deaths"],
        "global_new_deaths": myData["global_new_deaths"],
        "global_recovered": myData["global_recovered"],
        "global_active_cases": myData["global_new_cases"],
      };

      return globalData;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color trackerColor = Colors.white;
    Color symptomsColor = Colors.amber;
    return FutureBuilder(
      future: _future,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.error != null) {
          return Text("Something went wrong");
        }
        if (isLocal) {
          conform = localData['local_total_cases'].toString();
          active = localData['local_active_cases'].toString();
          recovered = localData['local_recovered'].toString();
          death = localData['local_deaths'].toString();
        }
        return Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            color: Colors.blue[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/agreement');
                  },
                  icon: Icon(Icons.connect_without_contact_sharp),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/qrScanner');
                  },
                  icon: Icon(Icons.qr_code),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/stateChange');
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => Scan()));
                  },
                  icon: Icon(
                    Icons.health_and_safety,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Center(
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/images/Banner.png",
                          width: double.infinity,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/symptoms');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 35,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: trackerColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        trackerColor = Colors.pink;
                                        symptomsColor = Colors.amber;
                                      });
                                    },
                                    child: Text(
                                      "Tracker",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 35,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: symptomsColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/symptoms');
                                    },
                                    child: Text(
                                      "Symptoms",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: double.infinity,
                        height: 20,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Text(
                                    "Country",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    isLocal = true;
                                    isGloble = false;
                                    conform = localData['local_total_cases']
                                        .toString();
                                    active = localData['local_active_cases']
                                        .toString();
                                    recovered =
                                        localData['local_recovered'].toString();
                                    death =
                                        localData['local_deaths'].toString();
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 200),
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 70),
                                  child: Text(
                                    "Worldwide",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    print("Check");
                                    isGloble = true;
                                    isLocal = false;
                                    conform = globalData['global_total_cases']
                                        .toString();
                                    active = globalData['global_active_cases']
                                        .toString();
                                    recovered = globalData['global_recovered']
                                        .toString();
                                    death =
                                        globalData['global_deaths'].toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          DetailsTile(
                              size: size,
                              title: "Confirmend",
                              count: conform,
                              color: Color.fromARGB(255, 85, 224, 178)),
                          SizedBox(
                            width: 15,
                          ),
                          DetailsTile(
                              size: size,
                              title: "Active",
                              count: active,
                              color: Color.fromARGB(212, 230, 65, 65)),
                          // color: Color(0xe70),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          DetailsTile(
                              size: size,
                              title: "Recovered",
                              count: recovered,
                              color: Color.fromARGB(255, 50, 224, 44)),
                          SizedBox(
                            width: 15,
                          ),
                          DetailsTile(
                              size: size,
                              title: "Deaths",
                              count: death,
                              color: Color.fromARGB(255, 134, 9, 9)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    Key? key,
    required this.size,
    required this.title,
    required this.count,
    required this.color,
  }) : super(key: key);

  final Size size;
  final String title;
  final String count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width / 2.2,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  count,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

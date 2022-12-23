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

  Future getHttp() async {
    try {
      var response = await Dio()
          .get('https://www.hpb.health.gov.lk/api/get-current-statistical');

      var myData = response.data["data"];

      localData = {
        "local_new_cases": myData["local_new_cases"],
        "local_total_cases": myData["local_total_cases"],
        // "local_total_number_of_individuals_in_hospitals":
        //     myData["local_total_number_of_individuals_in_hospitals"],
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
    bool tracker = true;
    bool symptoms = false;
    Color trackerColor = Colors.white;
    Color symptomsColor = Colors.amber;
    return FutureBuilder(
      future: getHttp(),
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
            color: Color.fromARGB(255, 20, 207, 221),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/nearByInt');
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

                // Text("sasdfdsf"),
                // Text("sasdfdsf"),
                // Text("sasdfdsf"),
              ],
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Center(
                  child: Image.asset(
                    "assets/images/Banner.png",
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 0.44,
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
                                  tracker = true;
                                  symptoms = false;
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
                        Container(
                          width: size.width * 0.44,
                          height: 35,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: symptomsColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   tracker = false;
                                //   symptoms = true;
                                //   trackerColor = Colors.amber;
                                //   symptomsColor = Colors.white;
                                // });
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            child: Text(
                              "Country",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                isLocal = true;
                                isGloble = false;
                                conform =
                                    localData['local_total_cases'].toString();
                                active =
                                    localData['local_active_cases'].toString();
                                recovered =
                                    localData['local_recovered'].toString();
                                death = localData['local_deaths'].toString();
                              });
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20, right: 20),
                        //   child: Text(
                        //     "State",
                        //     style: TextStyle(
                        //       fontSize: 14,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20, right: 20),
                        //   child: Text(
                        //     "City",
                        //     style: TextStyle(
                        //       fontSize: 14,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 200),
                          child: GestureDetector(
                            child: Text(
                              "Worldwide",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                print("Check");
                                isGloble = true;
                                isLocal = false;
                                conform =
                                    globalData['global_total_cases'].toString();
                                active = globalData['global_active_cases']
                                    .toString();
                                recovered =
                                    globalData['global_recovered'].toString();
                                death = globalData['global_deaths'].toString();
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
                          color: Color(0xff7477EC)),
                      SizedBox(
                        width: 15,
                      ),
                      DetailsTile(
                          size: size,
                          title: "Active",
                          count: active,
                          color: Color(0xff7477EC)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      DetailsTile(
                          size: size,
                          title: "Recovered",
                          count: recovered,
                          color: Color(0xff7477EC)),
                      SizedBox(
                        width: 15,
                      ),
                      DetailsTile(
                          size: size,
                          title: "Deaths",
                          count: death,
                          color: Color(0xff7477EC)),
                    ],
                  ),
                ),
              ],
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

// class StatusBar extends StatelessWidget {
//   const StatusBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isGloble = false;
//     bool isLocal = true;
//     return 
//   }
// }

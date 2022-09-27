import 'package:dating_app/QR/scan.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool tracker = true;
    bool symptoms = false;
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
              onPressed: () {},
              icon: Icon(Icons.search),
            ),

            IconButton(
              onPressed: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => Scan()));
              },
              icon: Icon(
                Icons.health_and_safety,
              ),
            ),

            IconButton(
              onPressed: () {},
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
                        color: tracker ? Colors.white : Colors.amber,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              tracker = true;
                              symptoms = false;
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
                        color: symptoms ? Colors.white : Colors.amber,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              tracker = false;
                              symptoms = true;
                            });
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
            StatusBar(),
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
                      count: "2,37,935",
                      color: Color(0xff7477EC)),
                  SizedBox(
                    width: 15,
                  ),
                  DetailsTile(
                      size: size,
                      title: "Active",
                      count: "12,935",
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
                      title: "Reserved",
                      count: "2,22,000",
                      color: Color(0xff7477EC)),
                  SizedBox(
                    width: 15,
                  ),
                  DetailsTile(
                      size: size,
                      title: "Deceases",
                      count: "37,892",
                      color: Color(0xff7477EC)),
                ],
              ),
            ),
          ],
        ),
      ),
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

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 20,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Country",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "State",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "City",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Worldwide",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ));
  }
}

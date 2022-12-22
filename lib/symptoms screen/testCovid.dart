import 'package:dating_app/symptoms%20screen/symptoms.dart';
import 'package:dating_app/symptoms%20screen/vaccineStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestCovid extends StatelessWidget {
  const TestCovid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 51, 131, 205),
                  Color(0xFF11249F),
                ],
              ),
              image: const DecorationImage(
                image: AssetImage("assets/images/virus.png"),
                fit: BoxFit.fitWidth,
              )),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Self Check Up For Covid-19.",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SpreadScreen(),
                            ),
                          );
                        },
                        child: const Text('< Prevent'),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image(
                  image: AssetImage(
                    "assets/images/testcovid.png",
                  ),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Have you experienced any of the following symptoms:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/images/t.png")),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 24,
                  color: Colors.white,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(16.0),
                  //       child: Text(
                  //         "Fever",
                  //         textAlign: TextAlign.left,
                  //         style: TextStyle(fontSize: 20),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Text(
                  //     "Caught",
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Text(
                  //     "Sor Throat",
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Text(
                  //     "headache",
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Text(
                  //     "Dificult in Breasthing",
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "    If you have bellow symptoms you are at a risk of Covid-19 ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              )
            ], //vacined or not

            //Container()
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 24,
                  color: Colors.black,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Are you vaccined or not?",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const VaccineStatus(),
                        ),
                      );
                    },
                    child: const Text('Vaccine Details >'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Image(image: AssetImage("assets/images/vaccine.png")),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "    If you didn't vaccined yet ,\n   You have risk of Covid-19 ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}

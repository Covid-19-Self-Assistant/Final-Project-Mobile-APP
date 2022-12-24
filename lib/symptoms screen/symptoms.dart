import 'package:dating_app/symptoms%20screen/testCovid.dart';
import 'package:flutter/material.dart';

class SpreadScreen extends StatelessWidget {
  const SpreadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CardDetails> _symptomsCards = [
      CardDetails(image: "assets/images/headache.png", title: "Headache"),
      CardDetails(image: "assets/images/caugh.png", title: "Caugh"),
      CardDetails(image: "assets/images/fever.png", title: "Fever"),
    ];

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                            "All you need \nis stay at home.",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const TestCovid(),
                                  ),
                                );
                              },
                              child: Text('Self  Check >'),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image(
                      image: AssetImage(
                        "assets/images/doctor.png",
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Symptoms",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _symptomsCards
                          .map((card) => SymptomsCard(
                                image: card.image,
                                title: card.title,
                              ))
                          .toList(),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Prevention",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PreventCard(
                    text:
                        "Since the start of the coronavirus outbreak some places have fully embraced wearing facemarks.",
                    image: "assets/images/wear_mask.png",
                    title: "Wear Face Mask",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PreventCard(
                    text:
                        "Since the start of the coronavirus outbreak some places have fully embraced wearing facemarks",
                    image: "assets/images/wash_hands.png",
                    title: "Wash your Hands",
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                ],
              ),
            ),
          ]),
    ));
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 136,
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
          ),
          Image.asset(image),
          Positioned(
            left: 130,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              height: 136,
              width: MediaQuery.of(context).size.width - 170,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(04)),
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class CardDetails {
  String image;
  String title;
  CardDetails({required this.image, required this.title});
}

class SymptomsCard extends StatelessWidget {
  final String image;
  final String title;
  const SymptomsCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 5,
            color: Colors.black,
          )
        ],
      ),
      child: Column(
        children: [
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

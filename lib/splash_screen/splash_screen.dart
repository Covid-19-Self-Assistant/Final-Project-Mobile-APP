import 'package:animate_do/animate_do.dart';
import 'package:dating_app/get_started/get_started_home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GetStartedHome()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeOut(
                child: Container(
                  child: Image.asset("assets/images/splash_sccreen.png"),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Covid 19 Self Assistent",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

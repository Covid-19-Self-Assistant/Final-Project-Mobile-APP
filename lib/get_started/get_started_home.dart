import 'package:dating_app/login/login_home.dart';
import 'package:dating_app/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedHome extends StatefulWidget {
  const GetStartedHome({Key? key}) : super(key: key);

  @override
  _GetStartedHomeState createState() => _GetStartedHomeState();
}

class _GetStartedHomeState extends State<GetStartedHome> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  autoLogin() async {
    final SharedPreferences prefs = await _prefs;
    var isLogin = prefs.getBool("isLogin");
    if (isLogin == true) {
      Navigator.pushNamed(context, '/details');
    }
  }

  @override
  void initState() {
    autoLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: size.height / 12,
              left: size.width / 15,
              bottom: size.width / 15,
            ),
            child: Image.asset("assets/images/people.png"),
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                left: size.width / 15,
                right: size.width / 15,
                bottom: size.width / 15,
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        "Let’s get Health assistant ☺",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: size.width,
                    child: Text(
                      "The best option to protect yourself.",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 12,
                  ),
                  Flexible(
                    child: Container(
                      width: size.width,
                      child: Button.RoseButton(
                          context, "Get Started", LoginFormValidation()),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

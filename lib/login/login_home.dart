import 'package:dating_app/details_pages/details_screen.dart';
import 'package:dating_app/home_page/Homepage.dart';
import 'package:dating_app/registration_page/registration_home.dart';
import 'package:dating_app/trouble_login/trouble_login_home.dart';
import 'package:dating_app/utils/button.dart';
import 'package:dating_app/utils/dividerl_line.dart';
import 'package:dating_app/utils/footer_text.dart';
import 'package:dating_app/utils/two_icon_button.dart';
import 'package:dating_app/utils/input_box.dart';
import 'package:dating_app/utils/labels.dart';
import 'package:flutter/material.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height / 8,
                      child: Image.asset("assets/images/heart.png"),
                    ),
                    Container(
                      width: size.width / 2.3,
                      height: size.height / 5,
                      margin: EdgeInsets.only(left: size.width / 10),
                      child: Text(
                        "Login to a Healthy life",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: size.height / 3,
                  width: size.width / 5,
                  child: Image.asset("assets/images/couple.png"),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 90,
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width / 15,
                right: size.width / 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Labels.inputlabels("Enter your Email"),
                  InputBox.UserInput(false),
                  Labels.inputlabels("Enter your Password"),
                  InputBox.UserInput(true),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TroubleLoginHome()));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(left: size.width / 1.6, bottom: 5),
                      child: Text("Trouble login?"),
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Button.RoseButton(context, "Login", DetailsPage()),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  Container(child: DividerLine.DividerOr(size)),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  TwoIconButton.iconbuton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationHome(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Don't you have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  FooterText.FotterMessage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // bool isNull() {
  //   if (_email.text.isEmpty) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}

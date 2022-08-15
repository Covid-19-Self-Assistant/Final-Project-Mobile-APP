import 'package:dating_app/home_page/Homepage.dart';
import 'package:dating_app/utils/button.dart';
import 'package:dating_app/utils/dividerl_line.dart';
import 'package:dating_app/utils/footer_text.dart';
import 'package:dating_app/utils/input_box.dart';
import 'package:dating_app/utils/labels.dart';
import 'package:dating_app/utils/two_icon_button.dart';
import 'package:flutter/material.dart';

class RegistrationHome extends StatefulWidget {
  const RegistrationHome({Key? key}) : super(key: key);

  @override
  _RegistrationHomeState createState() => _RegistrationHomeState();
}

class _RegistrationHomeState extends State<RegistrationHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: size.height / 4.5,
                child: Image.asset("assets/images/register.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width / 15,
                right: size.width / 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register Here",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  Labels.inputlabels("Enter your Email"),
                  InputBox.UserInput(false),
                  Labels.inputlabels("Enter your mobile number"),
                  InputBox.UserInput(false),
                  Labels.inputlabels("Enter your Password"),
                  InputBox.UserInput(true),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  Container(
                    width: size.width,
                    child: Button.RoseButton(context, "Register", HomePage()),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Container(child: DividerLine.DividerOr(size)),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  TwoIconButton.iconbuton(size),
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
}

import 'package:dating_app/home_page/Homepage.dart';
import 'package:dating_app/utils/button.dart';
import 'package:dating_app/utils/footer_text.dart';
import 'package:dating_app/utils/input_box.dart';
import 'package:dating_app/utils/labels.dart';
import 'package:flutter/material.dart';

class TroubleLoginHome extends StatefulWidget {
  const TroubleLoginHome({Key? key}) : super(key: key);

  @override
  _TroubleLoginHomeState createState() => _TroubleLoginHomeState();
}

class _TroubleLoginHomeState extends State<TroubleLoginHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: size.height / 15),
              child: Image.asset("assets/images/foget.png"),
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width / 15,
                right: size.width / 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    child: Text(
                      "Trouble Log In?",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Labels.inputlabels("Enter your Email"),
                  InputBox.UserInput(false),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  Container(
                    width: size.width,
                    child: Button.RoseButton(
                        context, "Send Reset Email", HomePage()),
                  ),
                  SizedBox(
                    height: size.height / 8,
                  ),
                  FooterText.FotterMessage()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

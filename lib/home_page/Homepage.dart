import 'package:dating_app/login/login_home.dart';
import 'package:dating_app/utils/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Button.RoseButton(context, "Back To Login", LoginFormValidation()),
        ),
      ),
    );
  }
}

import 'package:dating_app/login/login_home.dart';
import 'package:flutter/material.dart';

class Button {
  static RoseButton(BuildContext context , String label , Widget widget ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Colors.redAccent[400],
          padding: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    );
  }
}

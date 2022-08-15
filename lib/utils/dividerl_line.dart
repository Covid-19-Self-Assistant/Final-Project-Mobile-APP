import 'package:flutter/material.dart';

class DividerLine {
  static DividerOr(final size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: size.width / 6,
          height: 1,
          color: Colors.grey,
        ),
        Container(
          child: Text(
            "Or",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          width: size.width / 6,
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}

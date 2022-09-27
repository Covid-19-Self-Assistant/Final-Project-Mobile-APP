import 'package:flutter/material.dart';

class TwoIconButton {
  static iconbuton(final size) {
    return Container(
      child: Row(
        children: [
          Container(
              width: size.width / 2.5,
              height: size.height / 13,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Image.network(
                  'http://pngimg.com/uploads/google/google_PNG19635.png')),
          SizedBox(
            width: size.width / 15,
          ),
          Container(
            width: size.width / 2.5,
            height: size.height / 13,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Icon(
              Icons.facebook,
              color: Colors.blue,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

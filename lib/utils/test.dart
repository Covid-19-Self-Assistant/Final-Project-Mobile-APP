import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigment"),
      ),
      body: Center(
        child: Container(
          child: TextButton(
            onPressed: () {

            },
            child: Text("Click Here"),
          ),
        ),
      ),
    );
  }
}

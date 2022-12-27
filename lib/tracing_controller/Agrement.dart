import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  List<String> agreements = [
    'Contact tracing is a public health practice that involves identifying, assessing, and managing individuals who have been in close contact with a person who has tested positive for a contagious disease. One way to assist with contact tracing efforts is through the use of a contact tracing app, which can help to quickly and accurately identify individuals who may have been exposed to the disease \n',
    "A contact tracing app typically works by using Bluetooth technology to track and record other devices that have come into close proximity with the app user's device. When a person tests positive for the disease, they can enter this information into the app, which will then alert other app users who have been in close contact with the infected person \n",
  ];

  String? documentName = "";
  final users = FirebaseFirestore.instance.collection('users');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoading = false;
  bool isAgreed = false;

  Future getAgreementDetails() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      documentName = prefs.getString("email");
    });
    try {
      setState(() {
        isLoading = true;
      });
      DocumentSnapshot<Map<String, dynamic>> status =
          await users.doc(documentName).get();
      Map<String, dynamic>? data = status.data();

      if (data != null) {
        setState(() {
          isAgreed = data['isAgreed'];
        });
      }
      print(isAgreed);
      if (isAgreed) {
        Navigator.pushReplacementNamed(context, '/nearByInt');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void continueHandler() async {
    try {
      setState(() {
        isLoading = true;
      });
      await users.doc(documentName).update({"isAgreed": true});
      Navigator.pushReplacementNamed(context, '/nearByInt');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getAgreementDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Agreement'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/check.png'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ...agreements.map((agreement) => Text(agreement)),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.blue[900],
                      onPressed: continueHandler,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

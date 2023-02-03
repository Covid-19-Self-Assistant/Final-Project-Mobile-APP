import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateChanger extends StatefulWidget {
  final String title;

  const StateChanger({
    required this.title,
  });

  @override
  State<StateChanger> createState() => _StateChangerState();
}

class _StateChangerState extends State<StateChanger> {
  bool value = false;
  bool isLoading = false;

  String? documentName = "";
  final users = FirebaseFirestore.instance.collection('users');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future changeCovidStatus(bool value) async {
    return users.doc(documentName).update({"covidStatus": value});
  }

  Future getTheUsesCovidStatus() async {
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
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic>? data = status.data();
      if (data != null) {
        setState(() {
          value = data['covidStatus'] as bool;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // TODO: error handling
    }
  }

  @override
  void initState() {
    getTheUsesCovidStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    Spacer(),
                    Image.asset(
                      // value ? 'assets/images/on.png' : 'assets/images/off.png',
                      value
                          ? 'assets/images/positive.PNG'
                          : 'assets/images/negative.PNG',
                      height: 300,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      // margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Update here only after you know for sure that you are a corona patient.",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),
                    ),
                    Spacer(),
                    buildPlatforms(),
                    const SizedBox(height: 12),
                    const SizedBox(height: 12),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildPlatforms() => Row(
        children: [
          Expanded(
            child: buildHeader(
                text: value == true ? 'Covid Positive' : 'Covid Negative',
                child: buildIOSSwitch()),
          ),
        ],
      );

  Widget buildHeader({
    required Widget child,
    required String text,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );

  Widget buildIOSSwitch() => Transform.scale(
        scale: 1.1,
        child: CupertinoSwitch(
          value: value,
          onChanged: (value) async {
            try {
              setState(() {
                isLoading = true;
              });
              await changeCovidStatus(value);
              setState(() {
                this.value = value;
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Successfully update the covid status."),
              ));
            } catch (e) {
              setState(() {
                isLoading = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Unable to change the covid status"),
              ));
            }
          },
        ),
      );

  Widget buildAndroidSwitch() => Transform.scale(
        scale: 2,
        child: Switch(
          value: value,
          onChanged: (value) async {
            try {
              setState(() {
                isLoading = true;
              });
              await changeCovidStatus(value);
              setState(() {
                this.value = value;
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Successfully update the covid status."),
              ));
            } catch (e) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Unable to change the covid status"),
              ));
            }
          },
        ),
      );
}

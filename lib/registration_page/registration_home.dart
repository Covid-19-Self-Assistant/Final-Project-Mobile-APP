import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/login/login_home.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'theme_helper.dart';

class RegistrationHome extends StatefulWidget {
  const RegistrationHome({Key? key}) : super(key: key);

  @override
  _RegistrationHomeState createState() => _RegistrationHomeState();
}

class _RegistrationHomeState extends State<RegistrationHome> {
  final _formKey = GlobalKey<FormState>();
  var _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool checkedValue = false;
  bool showSnipper = false;
  bool checkboxValue = false;
  late TextEditingController firstName = TextEditingController();
  late TextEditingController lastName = TextEditingController();
  late TextEditingController birthday = TextEditingController();
  late TextEditingController mobile = TextEditingController();
  late TextEditingController _email = TextEditingController();
  late TextEditingController _password = TextEditingController();
  late TextEditingController _deviceInfo = TextEditingController();
  TextEditingController _date = TextEditingController();
  bool isLoading = false;

  final deviceInfoPlugin = DeviceInfoPlugin();

  void _getDeviceInformations() async {
    String? address = await FlutterBluetoothSerial.instance.address;

    setState(() {
      if (address != null) _deviceInfo.text = address;
    });
  }

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

                  Container(
                    child: TextFormField(
                      decoration: ThemeHelper().textInputDecoration(
                          'First Name', 'Enter your first name'),
                      onChanged: (value) {
                        firstName.text = value;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: TextFormField(
                      decoration: ThemeHelper().textInputDecoration(
                          'Last Name', 'Enter your last name'),
                      onChanged: (value) {
                        lastName.text = value;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextFormField(
                      // controller: _email,
                      decoration: ThemeHelper().textInputDecoration(
                          "E-mail address", "Enter your email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (!(val!.isEmpty) &&
                            !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                .hasMatch(val)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email.text = value;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        mobile.text = value;
                      },
                      decoration: ThemeHelper().textInputDecoration(
                          "Mobile Number", "Enter your mobile number"),
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (!(val!.isEmpty) &&
                            !RegExp(r"^(\d+)*$").hasMatch(val)) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(height: 20.0),

                  //Birthday
                  Container(
                    child: TextFormField(
                      controller: birthday,
                      decoration: ThemeHelper().textInputDecoration(
                          'BirthDay', 'Enter your BirthDay'),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2101),
                        );

                        if (pickeddate != null) {
                          var year = pickeddate.year;
                          var month = pickeddate.month;
                          var day = pickeddate.day;
                          var date = '$year/$month/$day';
                          setState(() {
                            print(pickeddate);
                            birthday.text = date;
                          });
                        }
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Container(
                    child: TextFormField(
                      // controller: _password,
                      obscureText: true,
                      decoration: ThemeHelper().textInputDecoration(
                          "Password*", "Enter your password"),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password.text = value;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(height: 15.0),
                  MaterialButton(
                    onPressed: _getDeviceInformations,
                    child: Text('Device Infor'),
                  ),

                  if (_deviceInfo.text != "")
                    Container(
                      child: TextFormField(
                        enabled: false,
                        controller: _deviceInfo,
                        decoration: ThemeHelper().textInputDecoration(
                            "Device Infor*", "Enter your device infor"),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your device infor";
                          }
                          return null;
                        },
                        onChanged: null,
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),

                  FormField<bool>(
                    builder: (state) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkboxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue = value!;
                                      state.didChange(value);
                                    });
                                  }),
                              Text(
                                "I accept all terms and conditions.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.errorText ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    validator: (value) {
                      if (!checkboxValue) {
                        return 'You need to accept terms and conditions';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  Center(
                    child: Container(
                      // decoration: ThemeHelper().buttonBoxDecoration(context),
                      decoration: BoxDecoration(
                          color: Colors.redAccent[400],
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "REGISTER",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                          onPressed: () async {
                            setState(() {
                              showSnipper = true;
                            });

                            try {
                              setState(() {
                                isLoading = true;
                              });
                              final UserCredential newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                email: _email.text,
                                password: _password.text,
                              );
                              if (newUser.user != null &&
                                  newUser.user!.email != null) {
                                _firestore
                                    .collection('users')
                                    .doc(_email.text)
                                    .set({
                                  'firstName': firstName.text,
                                  'lastName': lastName.text,
                                  'email': _email.text,
                                  'mobile': mobile.text,
                                  'birthDay': birthday.text,
                                  'device': _deviceInfo.text
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginFormValidation()),
                                    (Route<dynamic> route) => false);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              print(e);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
              // ],
            ),
            // ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  FaIcon(googlePlus, {required int size, required Color colors}) {}
}

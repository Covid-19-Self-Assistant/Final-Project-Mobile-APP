import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/home_page/Homepage.dart';
import 'package:dating_app/login/login_home.dart';
import 'package:dating_app/utils/button.dart';
import 'package:dating_app/utils/dividerl_line.dart';
import 'package:dating_app/utils/footer_text.dart';
import 'package:dating_app/utils/input_box.dart';
import 'package:dating_app/utils/labels.dart';
import 'package:dating_app/utils/two_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  // final _email = TextEditingController();
  // final _password = TextEditingController();
  late String _email;
  late String _password;
  late String username;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var FontAwesomeIcons;
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
                        username = value;
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
                        _email = value;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: TextFormField(
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
                        _password = value;
                      },
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  ),
                  SizedBox(height: 15.0),
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

                  // Labels.inputlabels("Enter your Email"),
                  // InputBox.UserInput(false),
                  // Labels.inputlabels("Enter your mobile number"),
                  // InputBox.UserInput(false),
                  // Labels.inputlabels("Enter your Password"),
                  // InputBox.UserInput(true),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  // Container(
                  //   width: size.width,
                  //   child: Button.RoseButton(context, "Register", HomePage()),
                  // ),
                  // SizedBox(
                  //   height: size.height / 40,
                  // ),
                  // Container(child: DividerLine.DividerOr(size)),
                  // SizedBox(
                  //   height: size.height / 40,
                  // ),
                  // TwoIconButton.iconbuton(size),
                  // SizedBox(
                  //   height: size.height / 40,
                  // ),
                  // FooterText.FotterMessage()
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
                            child: Text(
                              "Register".toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            // if (_formKey.currentState!.validate()) {
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             LoginFormValidation()),
                            //     (Route<dynamic> route) => false);

                            setState(() {
                              showSnipper = true;
                            });

                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                email: _email,
                                password: _password,
                              );
                              if (newUser != null) {
                                _firestore.collection('users').doc(_email).set({
                                  'First Name': username,
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginFormValidation()),
                                    (Route<dynamic> route) => false);
                              }
                              setState(() {
                                showSnipper = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          }

                          // },
                          ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  // Text(
                  //   "Or create account using social media",
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                  // SizedBox(height: 25.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       child: FaIcon(
                  //         FontAwesomeIcons.googlePlus,
                  //         size: 35,
                  //         colors: Color(0xEC2D2F),
                  //       ),
                  //       onTap: () {
                  //         setState(() {
                  //           showDialog(
                  //             context: context,
                  //             builder: (BuildContext context) {
                  //               return ThemeHelper().alartDialog(
                  //                   "Google Plus",
                  //                   "You tap on GooglePlus social icon.",
                  //                   context);
                  //             },
                  //           );
                  //         });
                  //       },
                  //     ),
                  // SizedBox(
                  //   width: 30.0,
                  // ),
                  // GestureDetector(
                  //   child: Container(
                  //     padding: EdgeInsets.all(0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(100),
                  //       border: Border.all(
                  //         width: 5,
                  //         color: Color(0x40ABF0),
                  //       ),
                  //       color: Color(0x40ABF0),
                  //     ),
                  //     child: FaIcon(
                  //       FontAwesomeIcons.twitter,
                  //       size: 23,
                  //       colors: Color(0xFFFFFF),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     setState(() {
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return ThemeHelper().alartDialog("Twitter",
                  //               "You tap on Twitter social icon.", context);
                  //         },
                  //       );
                  //     });
                  //   },
                  // ),
                  // SizedBox(
                  //   width: 30.0,
                  // ),
                  // GestureDetector(
                  //   child: FaIcon(
                  //     FontAwesomeIcons.facebook,
                  //     size: 35,
                  //     colors: Color(0x3E529C),
                  //   ),
                  //   onTap: () {
                  //     setState(() {
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return ThemeHelper().alartDialog(
                  //               "Facebook",
                  //               "You tap on Facebook social icon.",
                  //               context);
                  //         },
                  //       );
                  //     });
                  //   },
                  // ),
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

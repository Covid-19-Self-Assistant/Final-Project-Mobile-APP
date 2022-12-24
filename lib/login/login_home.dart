import 'package:dating_app/details_pages/details_screen.dart';
import 'package:dating_app/registration_page/registration_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'HomePage.dart';

class LoginFormValidation extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: null, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/heart.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                              "Password should not be greater than 15 characters")
                    ])
                    //validatePassword,        //Function to check validation
                    ),
              ),
              TextButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.redAccent[400], fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.redAccent[400],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                          email: _email.text,
                          password: _password.text,
                        );
                        if (userCredential.user != null &&
                            userCredential.user!.email != null) {
                          final SharedPreferences prefs = await _prefs;
                          prefs.setBool("isLogin", true);
                          if (userCredential.user!.email!.isNotEmpty)
                            prefs.setString(
                                "email", userCredential.user!.email!);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => DetailsPage()));
                          print("Validated");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        print(e);
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  MaterialButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel')),
                                ],
                                content: Text("Invalid user credintials"),
                              );
                            });
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegistrationHome()));
                  },
                  child: Text('New User? Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

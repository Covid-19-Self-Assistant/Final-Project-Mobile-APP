import 'package:dating_app/QR/qr_scanner.dart';
import 'package:dating_app/details_pages/details_screen.dart';
import 'package:dating_app/login/login_home.dart';
import 'package:dating_app/profile_page/ConnectivityDetails.dart';
import 'package:dating_app/profile_page/ProfilePage.dart';
import 'package:dating_app/profile_page/ConnectedUsers.dart';
import 'package:dating_app/splash_screen/splash_screen.dart';
import 'package:dating_app/symptoms%20screen/symptoms.dart';
import 'package:dating_app/tracing_controller/ShowDevices.dart';
import 'package:dating_app/update_positive/updateStatus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19 Tracing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/details': (context) => DetailsPage(),
        '/connectivityDetails': (context) => ConnectivityDetails(),
        '/login': (context) => LoginFormValidation(),
        '/nearByInt': (context) => ShowDevices(),
        '/symptoms': (context) => SpreadScreen(),
        '/profile': (context) => ProfilePage(),
        '/usersList': (context) => ConnectedUsers(),
        '/qrScanner': (context) => MyHomePage(
              title: 'QR Scanner',
            ),
        '/stateChange': (context) => StateChanger(
              title: 'Change Your State',
            ),
      },
    );
  }
}

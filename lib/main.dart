import 'package:dating_app/QR/qr_scanner.dart';
import 'package:dating_app/splash_screen/splash_screen.dart';
import 'package:dating_app/symptoms%20screen/symptoms.dart';
import 'package:dating_app/tracing_controller/nearbyInterface.dart';
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
        '/nearByInt': (context) => NearbyInterface(),
        '/symptoms': (context) => SpreadScreen(),
        '/qrScanner': (context) => MyHomePage(
              title: 'QR Scanner',
            ),
      },
    );
  }
}

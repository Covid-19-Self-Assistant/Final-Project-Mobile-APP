import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  List<String> conditions = [
    '    \n',
    '1. Our app is intended for informational purposes only and should not be used as a substitute for professional medical advice. If you have any concerns about your health, please contact a healthcare professional.',
    '    \n',
    '2. The information provided by our app is based on publicly available data and is subject to change without notice. We cannot guarantee the accuracy, completeness, or timeliness of the information.',
    '    \n',
    '3. We reserve the right to update these terms and conditions at any time without notice. By continuing to use our app, you agree to be bound by the most recent version of these terms and conditions.',
    '\n',
    'Thank you for using our COVID-19 tracking app! We hope you find it helpful and informative.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[900]),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to our COVID-19 tracking app! By using our app, you agree to the following terms and conditions:",
                style: TextStyle(fontSize: 20),
              ),
              ...conditions.map((condition) => Text(condition)),
            ],
          ),
        ),
      ),
    );
  }
}

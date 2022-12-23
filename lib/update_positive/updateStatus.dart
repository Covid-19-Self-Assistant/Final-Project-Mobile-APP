import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StateChanger extends StatefulWidget {
  final String title;

  const StateChanger({
    required this.title,
  });

  @override
  State<StateChanger> createState() => _StateChangerState();
}

class _StateChangerState extends State<StateChanger> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              // value ? 'assets/images/on.png' : 'assets/images/off.png',
              value
                  ? 'assets/images/positive.PNG'
                  : 'assets/images/negative.PNG',
              height: 300,
            ),
            Spacer(),
            buildPlatforms(),
            const SizedBox(height: 12),
            // buildHeader(
            //   text: 'Adaptive',
            //   child: buildSwitch(),
            // ),
            // const SizedBox(height: 12),
            // buildHeader(
            //   text: 'Android Image',
            //   child: buildSpecialAndroidSwitch(),
            // ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget buildPlatforms() => Row(
        children: [
          // Expanded(
          //   child: buildHeader(text: 'Android', child: buildAndroidSwitch()),
          // ),
          Expanded(
            child:
                buildHeader(text: value == true ? 'Covid Positive' : 'Covid Negative', child: buildIOSSwitch()),
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

  // Widget buildSwitch() => Transform.scale(
  //       scale: 2,
  //       child: Switch.adaptive(
  //         thumbColor: MaterialStateProperty.all(Colors.red),
  //         trackColor: MaterialStateProperty.all(Colors.orange),

  //         // activeColor: Colors.blueAccent,
  //         // activeTrackColor: Colors.blue.withOpacity(0.4),
  //         // inactiveThumbColor: Colors.orange,
  //         // inactiveTrackColor: Colors.black87,
  //         splashRadius: 50,
  //         value: value,
  //         onChanged: (value) => setState(() => this.value = value),
  //       ),
  //     );

  Widget buildIOSSwitch() => Transform.scale(
        scale: 1.1,
        child: CupertinoSwitch(
          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );

  Widget buildAndroidSwitch() => Transform.scale(
        scale: 2,
        child: Switch(
          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );

  // Widget buildSpecialAndroidSwitch() => Transform.scale(
  //       scale: 2,
  //       child: SizedBox(
  //         width: 75,
  //         child: Switch(
  //           trackColor: MaterialStateProperty.all(Colors.black38),

  //           // thumb colors
  //           activeColor: Colors.green.withOpacity(0.4),
  //           inactiveThumbColor: Colors.red.withOpacity(0.4),

  //           activeThumbImage: AssetImage('assets/images/thumbs_up.png'),
  //           inactiveThumbImage: AssetImage('assets/images/thumbs_down.png'),
  //           value: value,
  //           onChanged: (value) => setState(() => this.value = value),
  //         ),
  //       ),
  //     );
}

import 'package:dating_app/components/constants.dart';
import 'package:dating_app/details_pages/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ShowDevices extends StatefulWidget {
  @override
  _ShowDevicesState createState() => _ShowDevicesState();
}

class _ShowDevicesState extends State<ShowDevices> {
  // Initialize a list to store the Bluetooth devices
  List<BluetoothDiscoveryResult> _devices = <BluetoothDiscoveryResult>[];

  var type = false;

  void _startScan() async {
    _devices.clear();
    FlutterBluetoothSerial.instance.startDiscovery().listen((value) {
      // Update the list of Bluetooth map
      print(value);
      setState(() {
        if (_devices.contains((device) => device != value)) {
          _devices.add(value);
        }
      });
    });
  }

  void _syncDialogModal() async {
    // TODO: send the api call and identify the user from the device

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                  onPressed: () {
                    type = false;
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              MaterialButton(
                  onPressed: () {
                    type = true;
                    // TODO: send the api call to store sync data in database
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
            ],
            content: Text('Do you want to sync with **** ?'),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.deepPurple,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DetailsPage()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Covid 19 Self Assistance',
          style: TextStyle(
            color: Colors.deepPurple[800],
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                bottom: 10.0,
                top: 30.0,
              ),
              child: Container(
                height: 100.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[500],
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/images/corona.png'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Your Contact Traces',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 21.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: _startScan,
              child: Text(
                'Start Tracing',
                style: kButtonTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(_devices[index].device.name.toString()),
                    subtitle: Text(_devices[index].device.address.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.sync),
                      onPressed: _syncDialogModal,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

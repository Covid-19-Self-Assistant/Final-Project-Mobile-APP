import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ShowDevices extends StatefulWidget {
  @override
  _ShowDevicesState createState() => _ShowDevicesState();
}

class _ShowDevicesState extends State<ShowDevices> {
  // Initialize a list to store the Bluetooth devices
  List<BluetoothDiscoveryResult> _devices = <BluetoothDiscoveryResult>[];

   void _startScan() async{
    _devices.clear();
    FlutterBluetoothSerial.instance.startDiscovery().listen((value) {
      // Update the list of Bluetooth map
      
      setState(() {
        _devices.add(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Devices'),
        ),
        body: ListView(
          children: _devices.map((device) {
            return ListTile(
              title: Text(device.device.name.toString()),
              subtitle: Text(device.device.address),
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _startScan,
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceDetails extends StatelessWidget {
  final ScanResult device;

  DeviceDetails({Key key, @required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Text(
            'Device mac: ${device.device.id}   \nDevice name: ${device.device.name}'),
      ),
    );
  }
}

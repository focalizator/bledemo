import 'package:bledemo/deviceDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceList extends StatefulWidget {
  @override
  DeviceListState createState() => new DeviceListState();
}

class DeviceListState extends State<DeviceList> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> deviceList = [];

  @override
  void initState() {
    super.initState();
  }

  bluetoothScan() async {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    print("Bluetooth devices: ${deviceList.length}");
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Press the button to scan"),
          ],
        ),
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBlue.instance.scanResults,
        initialData: [],
        builder: (context, snapsnot) {
          deviceList = snapsnot.data;
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
            child: ListView.builder(
                itemCount: snapsnot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DeviceDetails(device: snapsnot.data[index])));
                    },
                    child: Text(
                      'Device: ' + snapsnot.data[index].device.name,
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await bluetoothScan();
        },
      ),
    );
  }
}

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoScreen extends StatefulWidget {
  new({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo? deviceInfo;
  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  getDeviceInfo() async {
    deviceInfo = await deviceInfoPlugin.androidInfo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Device Info"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: deviceInfo != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Model Name: ${deviceInfo!.model}"),
                  Text("OS Version: ${deviceInfo!.version.release}"),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

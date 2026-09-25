import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_features_app/screens/image_gallery_screen.dart';
import 'package:flutter_device_features_app/widgets/navigation_text_button.dart';

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
    // This screen demonstrates Android-specific metadata, so query the plugin
    // once at screen startup instead of polling the device repeatedly.
    getDeviceInfo();
  }

  getDeviceInfo() async {
    // Reading model and OS metadata does not require a runtime permission.
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
                  SizedBox(height: 10),
                  NavigationTextButton(
                    text: "To Image Gallery Screen",
                    destination: ImageGalleryScreen(),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

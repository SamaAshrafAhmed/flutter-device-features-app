import 'package:flutter/material.dart';
import 'package:flutter_device_features_app/screens/device_info_screen.dart';
import 'package:flutter_device_features_app/screens/image_gallery_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeviceInfoScreen(),
    );
  }
}

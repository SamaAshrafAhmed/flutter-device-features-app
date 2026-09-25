import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // GoogleMap provides its controller after the native map surface is ready.
  // A completer keeps that asynchronous handoff available for future actions.
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  List<Marker> markers = [
    Marker(
      markerId: MarkerId("cairo"),
      position: LatLng(30.0444, 31.2357),
      infoWindow: InfoWindow(title: "Cairo Governorate"),
    ),
  ];
  static const CameraPosition cairoCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    // This demo shows a fixed map position of Cairo Governorate; it does not request device location.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Google Map"),
        backgroundColor: Colors.amber,
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(markers),
        mapType: MapType.satellite,
        initialCameraPosition: cairoCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(40.735657, -74.172363), zoom: 11.5);

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Google Maps',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ImageIcon(
            AssetImage("lib/assets/images/backicon.png"),
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 8.0,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (controller) => _googleMapController = controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }
}

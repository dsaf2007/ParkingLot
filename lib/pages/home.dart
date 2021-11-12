// home.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/reservations.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/widget/navigationBar.dart';
// google map
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // google map
  Completer<GoogleMapController> _controller = Completer();
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(35, 134),
  //   zoom: 15,
  // );
  static final CameraPosition _kLake =
      CameraPosition(target: LatLng(35, 135), zoom: 15);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.7,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition:
              CameraPosition(target: LatLng(30, 60), zoom: 15),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

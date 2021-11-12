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
  static final CameraPosition jungu =
      CameraPosition(target: LatLng(37.565, 127), zoom: 14);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: jungu,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}

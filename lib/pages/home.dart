// home.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parkinglot/widget/navigationBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  // google map
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition seoul =
      CameraPosition(target: LatLng(37.562, 127), zoom: 14);

  @override
  Widget build(BuildContext context) {
    int screenIndex = 0;
    // bottom nav bar
    return Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: seoul,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.medium);
// }

// Future<Position> getLocation() async {
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.low);
//   return position;
// }

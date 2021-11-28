// home.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/favorites.dart';
import '../widget/navigation_bar.dart';
import '../util/colors.dart';
import 'datetime_selection.dart';
// google map
import 'package:google_maps_flutter/google_maps_flutter.dart';
// map search
// import 'package:address_search_field/address_search_field.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// current position
// import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  // google map
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition seoul =
      CameraPosition(target: LatLng(37.562, 127), zoom: 15);

  @override
  Widget build(BuildContext context) {
    // final _geoMethods = GeoMethods(
    //   googleApiKey: 'GOOGLE_API_KEY',
    //   language: 'ko',
    //   countryCode: 'kr',
    //   country: 'The Republic of Korea ',
    //   city: 'Seoul',
    // );
    // CameraPosition currentLocation = seoul;
    // bool isValidCurrentLocation = false;
    // getLocation().then((value) {
    //   LatLng currentLatLng = LatLng(value.latitude, value.longitude);
    //   currentLocation = CameraPosition(target: currentLatLng, zoom: 14);
    //   isValidCurrentLocation = true;
    // });

    // todo : maker builder, dynamic create
    // List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {itmaps.asMap().forEach((mid, bmp)}
    List<Marker> markers = [
      Marker(
          markerId: MarkerId("testMarker1"),
          position: LatLng(37.552, 127),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Test"),
                    ));
          }),
      Marker(
        infoWindow: InfoWindow(
          title: "행복주차장",
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    Image.asset(
                      'lib/images/park.png',
                      height: 150,
                    ),
                    Divider(
                      height: 50,
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("주차장A",
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: blue,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text("주차장A주소"),
                              Text("주차장A전화번호"),
                              SizedBox(
                                height: 5,
                              ),
                              Text('30분 500 원   |   총 180 면'),
                            ]),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // todo
                                  builder: (context) => FavoritesPage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: lightGrey,
                                minimumSize: Size(200, 30)),
                            child: const Text('즐겨찾기 추가',
                                style: TextStyle(color: Colors.black)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DateTimeSelection()));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: blue,
                                minimumSize: Size(200, 30)),
                            child: const Text('예약하기',
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 5),
                        ])
                  ]),
                ),
                // --- 이미지 넣기 ---
              ),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Card(
            //       child: ListTile(
            //         onTap: () {},
            //         subtitle: Column(children: [
            //           Row(
            //             children: [
            //               Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text("주차장A",
            //                         style: TextStyle(
            //                             fontSize: 23,
            //                             color: blue,
            //                             fontWeight: FontWeight.bold)),
            //                     SizedBox(height: 5),
            //                     Text("주차장A주소"),
            //                     Text("주차장A전화번호"),
            //                     Text('30분 500 원   |   총 180 면'),
            //                   ]),
            //               SizedBox(width: 80),
            //               Image.asset('lib/images/park.png',
            //                   width: 100, height: 100),
            //             ],
            //           ),
            //           SizedBox(height: 5),
            //           Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 TextButton(
            //                   onPressed: () {},
            //                   style: TextButton.styleFrom(
            //                       backgroundColor: lightGrey,
            //                       minimumSize: Size(165, 20)),
            //                   child: const Text('즐겨찾기 추가',
            //                       style: TextStyle(color: Colors.black)),
            //                 ),
            //                 SizedBox(width: 10),
            //                 TextButton(
            //                   onPressed: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) =>
            //                                 DateTimeSelection()));
            //                   },
            //                   style: TextButton.styleFrom(
            //                       backgroundColor: blue,
            //                       minimumSize: Size(165, 20)),
            //                   child: const Text('예약하기',
            //                       style: TextStyle(color: Colors.white)),
            //                 ),
            //                 SizedBox(height: 5),
            //               ])
            //         ]),
            //         // --- 이미지 넣기 ---
            //       ),
            //     ),
            //   ),
            // );
          },
        ),
        markerId: MarkerId("testMarker2"),
        position: LatLng(37.562, 127),
      ),
    ];
    return Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: GoogleMap(
            markers: markers.toSet(),
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
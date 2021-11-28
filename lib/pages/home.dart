// home.dart
import 'dart:async';
import 'package:flutter/material.dart';

// google map
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkinglot/util/colors.dart';
import '../widget/navigation_bar.dart';
import 'datetime_selection.dart';
import 'favorites.dart';

// map search
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // google map
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition seoul =
      CameraPosition(target: LatLng(37.562, 127), zoom: 14);

  @override
  Widget build(BuildContext context) {
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
          },
        ),
        markerId: MarkerId("testMarker2"),
        position: LatLng(37.562, 127),
      ),
    ];

    return new Scaffold(
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

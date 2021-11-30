// // home.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:parkinglot/pages/favorites.dart';
// import '../widget/navigation_bar.dart';
// import '../util/colors.dart';
// // google map
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // map search
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // google map
//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition seoul =
//       CameraPosition(target: LatLng(37.562, 127), zoom: 15);

//   @override
//   Widget build(BuildContext context) {
//     List<Marker> markers = [
//       Marker(
//           markerId: MarkerId("testMarker1"),
//           position: LatLng(37.552, 127),
//           onTap: () {
//             showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                       title: Text("Test"),
//                     ));
//           }),
//       Marker(
//         infoWindow: InfoWindow(
//           title: "행복주차장",
//           onTap: () {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 content: Container(
//                   height: MediaQuery.of(context).size.height * 0.7,
//                   child: Column(children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(Icons.close),
//                         ),
//                       ],
//                     ),
//                     Image.asset(
//                       'lib/images/park.png',
//                       height: 150,
//                     ),
//                     Divider(
//                       height: 50,
//                       thickness: 2,
//                     ),
//                     Row(
//                       children: [
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("주차장A",
//                                   style: TextStyle(
//                                       fontSize: 23,
//                                       color: blue,
//                                       fontWeight: FontWeight.bold)),
//                               SizedBox(height: 5),
//                               Text("주차장A주소"),
//                               Text("주차장A전화번호"),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text('30분 500 원   |   총 180 면'),
//                             ]),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   // todo
//                                   builder: (context) => FavoritesPage(),
//                                 ),
//                               );
//                             },
//                             style: TextButton.styleFrom(
//                                 backgroundColor: lightGrey,
//                                 minimumSize: Size(200, 30)),
//                             child: const Text('즐겨찾기 추가',
//                                 style: TextStyle(color: Colors.black)),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               // todo
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             DateTimeSelection()));
//                             },
//                             style: TextButton.styleFrom(
//                                 backgroundColor: blue,
//                                 minimumSize: Size(200, 30)),
//                             child: const Text('예약하기',
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                           SizedBox(height: 5),
//                         ])
//                   ]),
//                 ),
//                 // --- 이미지 넣기 ---
//               ),
//             );
//           },
//         ),
//         markerId: MarkerId("testMarker2"),
//         position: LatLng(37.562, 127),
//       ),
//     ];
//     return Scaffold(
//       bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           width: MediaQuery.of(context).size.width * 0.9,
//           child: GoogleMap(
//             markers: markers.toSet(),
//             mapType: MapType.normal,
//             initialCameraPosition: seoul,
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// home.dart
// ignore_for_file: unused_element, non_constant_identifier_names, unnecessary_new

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/util/colors.dart';
import '../widget/navigation_bar.dart';
// google map
import 'package:google_maps_flutter/google_maps_flutter.dart';

// map search
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchQuery = TextEditingController();
  bool _IsSearching = false;
  String _searchText = "";

  List<ParkingLotItem> parkingLotItemList = [];
  List<ParkingLotItem> filterList = [];
  List<Marker> markerList = [];

  List<Marker> _getMarkersFromFilteredList() {
    // db에서 해당 주차장 주소를 가지고 있는 주차장들의 리스트
    filterList = [];
    for (int i = 0; i < parkingLotItemList.length; i++) {
      var item = parkingLotItemList[i];

      if (item.address.contains(_searchText)) {
        filterList.add(item);
      }
    }
    // filterList(해당 주소가 들어간 주차장들의 리스트)에서 각 주차장에 대해 Marker을 생성하여 반환

    for (int i = 0; i < filterList.length; i++) {
      markerList.add(
        Marker(
          infoWindow: InfoWindow(
            title: filterList[i].name,
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
                      Divider(
                        height: 50,
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${filterList[i].name}",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: blue,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text("${filterList[i].address}"),
                                Text("${filterList[i].telephone}"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '30분 ${filterList[i].fee} 원   |   총 ${filterList[i].total_space} 면'),
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
                                // todo
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
      );
    }
    return markerList;
  }

  // ignore: unused_element
  _HomeState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  // google map
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition seoul =
      CameraPosition(target: LatLng(37.562, 127), zoom: 15);

  final Stream<QuerySnapshot> parkinglots = FirebaseFirestore.instance
      .collection('ParkingLot')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: parkinglots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Sth Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          for (var doc in snapshot.data!.docs) {
            parkingLotItemList.add(ParkingLotItem(
                doc["name"],
                doc["address"],
                doc["telephone"],
                doc["parkingtime_permin"],
                doc["pay_fee"],
                doc["capacity"],
                doc["code"],
                true,
                doc["weekday_begin_time"],
                doc["weekday_end_time"],
                doc["weekend_begin_time"],
                doc["weekend_end_time"]));
          }

          // TODO: implement build
          return Scaffold(
              bottomNavigationBar:
                  NaviBarButtons(MediaQuery.of(context).size, context),
              body: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(children: [
                    TextField(
                      controller: _searchQuery,
                      decoration: InputDecoration(
                          hintText: "검색",
                          hintStyle: TextStyle(color: mediumGrey)),
                      onChanged: (text) {
                        _searchText = text;
                        _IsSearching = true;
                      },
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: GoogleMap(
                        // markers: _IsSearching
                        //     ? markerList.toSet()
                        //     : _getMarkersFromFilteredList().toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: seoul,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ]),
                ),
              ));
        });
  }
}

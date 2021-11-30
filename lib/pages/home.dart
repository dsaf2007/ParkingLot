import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/util/helper.dart';
import '../widget/navigation_bar.dart';
// google map
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeParkingLotItem {
  ParkingLotItem parkingLotItem;
  double lat;
  double lng;

  HomeParkingLotItem(this.parkingLotItem, this.lat, this.lng);
}

// map search
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchQuery = TextEditingController();
  bool _IsSearching = false;
  String _searchText = "";

  List<HomeParkingLotItem> parkingLotItemList = [];
  List<Marker> markerList = [];

  List<Marker> _getMarkersFromFilteredList() {
    final size = MediaQuery.of(context).size;
    Size doubleButtonSize = Size(size.width * 0.3, 20);
    // 각 주차장에 대해 Marker을 생성하여 반환
    for (int i = 0; i < parkingLotItemList.length; i++) {
      markerList.add(
        Marker(
          markerId: MarkerId(parkingLotItemList[i].parkingLotItem.name),
          position:
              LatLng(parkingLotItemList[i].lat, parkingLotItemList[i].lng),
          infoWindow: InfoWindow(
            title: parkingLotItemList[i].parkingLotItem.name,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Column(children: <Widget>[
                      Row(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${parkingLotItemList[i].parkingLotItem.name}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: blue,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text(
                                    "${parkingLotItemList[i].parkingLotItem.address}"),
                                Text(
                                    "${parkingLotItemList[i].parkingLotItem.telephone}"),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                    '30분 ${parkingLotItemList[i].parkingLotItem.fee} 원   |   총 ${parkingLotItemList[i].parkingLotItem.total_space} 면'),
                              ]),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FavoritesPage())),
                              style: buildDoubleButtonStyle(
                                lightGrey, doubleButtonSize),
                              child: const Text('즐겨찾기 추가',
                              style: TextStyle(color: Colors.black)),
                            ),
                            SizedBox(width: 15),
                            TextButton(
                              onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DateTimeSelection())),
                              style: buildDoubleButtonStyle(blue, doubleButtonSize),
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
        ),
      );
    }
    return markerList;
  }

  // google map6
  late GoogleMapController googleMapController;

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
            parkingLotItemList.add(HomeParkingLotItem(
                ParkingLotItem(
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
                    doc["weekend_end_time"]),
                doc['latitude'],
                doc['longitude']));
          }
          // TODO: implement build
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: TextField(
                  controller: _searchQuery,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: "확인하고자 하는 구를 입력하세요.",
                      hintStyle: TextStyle(color: mediumGrey)),
                  onChanged: (text) {
                    _searchText = text;
                    googleMapController.animateCamera(CameraUpdate.newLatLng(
                        LatLng(guLoc[_searchText]!.latitude,
                            guLoc[_searchText]!.longitude)));
                  },
                  textAlign: TextAlign.center,
                ),
                elevation: 0,
              ),
              body: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: GoogleMap(
                      markers: _getMarkersFromFilteredList().toSet(),
                      mapType: MapType.normal,
                      initialCameraPosition: seoul,
                      onMapCreated: (controller) =>
                          googleMapController = controller,
                    )),
              ),
              bottomNavigationBar:
                  NaviBarButtons(MediaQuery.of(context).size, context));
        });
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }
}

const Map<String, LatLng> guLoc = {
  '강남구': LatLng(37.551288121446156, 127.0830743266856),
  '강동구': LatLng(37.53611394777861, 127.13220461823461),
  '강북구': LatLng(37.64510346577025, 127.02589244665562),
  '강서구': LatLng(38.91756637410182, 125.52175994230569),
  '관악구': LatLng(37.41971931436645, 126.9084727692616),
  '광진구': LatLng(37.558251480209925, 127.07959686238752),
  '구로구': LatLng(37.50257836640183, 126.88154587138605),
  '금천구': LatLng(37.455832349437586, 126.89394935391981),
  '노원구': LatLng(37.655076825207274, 127.06042597035976),
  '도봉구': LatLng(37.679491927329536, 127.0455531846094),
  '동대문구': LatLng(37.57124627646314, 127.00886016640702),
  '동작구': LatLng(37.500713313856274, 126.9852569623006),
  '마포구': LatLng(37.53989213862349, 126.94602926926405),
  '서대문구': LatLng(37.56590604775484, 126.96669291344274),
  '서초구': LatLng(37.4924439980104, 127.00766754042728),
  '성동구': LatLng(37.546732840271105, 127.05747835177542),
  '성북구': LatLng(37.60393030065416, 127.01392052111908),
  '송파구': LatLng(37.499858144740486, 127.11220099768684),
  '양천구': LatLng(37.526225137775796, 126.8642580823441),
  '영등포구': LatLng(37.515591989602875, 126.90711806885136),
  '용산구': LatLng(37.52953114780489, 127.0088981670005),
  '은평구': LatLng(37.618930954433665, 126.92087418419807),
  '종로구': LatLng(37.56980032779329, 126.97618589927323),
  '중구': LatLng(37.56120109471284, 126.9947387265245),
  '중랑구': LatLng(37.59505699633432, 127.07587591303327)
};
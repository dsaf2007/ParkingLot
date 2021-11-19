import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/navigation_bar.dart';
import '../models/ParkingLot.dart';
import '../util/colors.dart';
import 'datetime_selection.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ParkingLot> parkinglot = [
    ParkingLot(
        'park.png', '대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '장충공영주차장1', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '필동공영주차장1', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '장충공영주차장2', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '대한극장주차장2', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '필동공영주차장2', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '장충공영주차장3', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '대한극장주차장3', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '필동공영주차장3', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: '주차장 검색',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ))),
      body: ListView.builder(
        itemCount: parkinglot.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
              child: Card(
                child: ListTile(
                  onTap: () {},
                  subtitle: Column(children: [
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(parkinglot[index].name,
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: blue,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(parkinglot[index].address),
                              Text(parkinglot[index].number),
                              Text(
                                  '30분 ${parkinglot[index].cost} 원   |   총 ${parkinglot[index].total_space} 면'),
                            ]),
                        SizedBox(width: 80),
                        Image.asset('lib/images/park.png',
                            width: 100, height: 100),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: lightGrey,
                                minimumSize: Size(165, 20)),
                            child: const Text('즐겨찾기 추가',
                                style: TextStyle(color: Colors.black)),
                          ),
                          SizedBox(width: 10),
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
                                minimumSize: Size(165, 20)),
                            child: const Text('예약하기',
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 5),
                        ])
                  ]),
                  // --- 이미지 넣기 ---
                ),
              ));
        },
      ),
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
    );
  }
}

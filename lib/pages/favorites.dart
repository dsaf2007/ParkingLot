import 'package:flutter/material.dart';
import 'package:parkinglot/models/ParkingLot.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigation_bar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List<ParkingLot> parkinglot = [
    ParkingLot(
        'park.png', '대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '장충공영주차장1', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
    ParkingLot(
        'park.png', '필동공영주차장1', '서울 중구 필동 2가', '02-1234-5678', 800, 30, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      appBar: AppBar(
          // 값 전달 받기
        title: Text('즐겨찾기',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, 
      ),
      body: ListView.builder(
        itemCount: parkinglot.length,
        itemBuilder: (context, index) {
          return Padding(padding:const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(parkinglot[index].name,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                    SizedBox(height: 10),
                                    Text(parkinglot[index].address),
                                    Text(parkinglot[index].number),
                                  ]
                                ),
                                SizedBox(width: 110),
                                Image.asset('lib/images/park.png',
                                  width: 70, 
                                  height: 70
                                ),
                              ], 
                            )                      
                          ],
                          ),
                      ],
                    )
                  ],
                ),
              ),
                  // --- 이미지 넣기 ---
            ),
          );
        },
      ),
    );
  }
}

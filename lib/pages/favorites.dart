import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'datetime_selection.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<ParkingLotItem> parkinglotlist = [
    //ParkingLotItem(this.image_path, this.name, this.address, this.telephone,
    // this.minute, this.fee, this.total_space, this.favorite);
    ParkingLotItem(
        '대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
    ParkingLotItem(
        '대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
    ParkingLotItem(
        '대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
    ParkingLotItem(
        '대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
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
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: parkinglotlist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
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
                                Image.asset('lib/images/park.png',
                                    width: 70, height: 70),
                                SizedBox(width: 10),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(parkinglotlist[index].name,
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text(parkinglotlist[index].address),
                                      Text(parkinglotlist[index].telephone),
                                    ]),
                                SizedBox(width: 60),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            TextButton(
                              // onPressed: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => FixProfileCKPW()
                              //     )
                              //   );
                              // },
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DateTimeSelection()));
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: blue,
                                  minimumSize: Size(350, 20)),
                              child: const Text('예약하기',
                                  style: TextStyle(color: Colors.white)),
                            ),
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

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
//import 'read.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

//addparkinglot func에서 사용하기 위해 전역으로
List<ParkingLotItem> parkinglot = [];

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favList = [];
  // String parkinglotName = "";
  // String parkinglotAdd = "";
  // String parkinglotPN = "";

  @override
  Widget build(BuildContext context) {
    String testUserName = 'leejaewon';
    CollectionReference favDB =
        FirebaseFirestore.instance.collection('Favorites');

    return FutureBuilder<QuerySnapshot>(
      future: favDB.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          parkinglot.clear();
          for (var doc in snapshot.data!.docs) {
            //list에 쌓이는 것 방지 clear로 초기화.
            //ParkingLotItem(this.image_path, this.name, this.address, this.telephone,
            // this.minute, this.fee, this.total_space, this.favorite);
            parkinglot.add(ParkingLotItem(
                doc["name"],
                doc["address"],
                doc["telephone"],
                doc["minute"],
                doc["fee"],
                doc["total_space"],
                false));
          }

          return SafeArea(
              child: Scaffold(
            bottomNavigationBar:
                NaviBarButtons(MediaQuery.of(context).size, context),
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
              itemCount: parkinglot.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 1.0),
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
                                            Text(parkinglot[index].name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 5),
                                            Text(parkinglot[index].address),
                                            Text(parkinglot[index].telephone),
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
          )); //scaffold
        }
        return CircularProgressIndicator();
      },
    );
  }
}

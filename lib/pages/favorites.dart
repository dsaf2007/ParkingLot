import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/providers/parkinglotdata.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'datetime_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<userData>(context, listen: false).name;
    // CollectionReference favDB =   FirebaseFirestore.instance.collection('Favorites');
    final Stream<QuerySnapshot> favDB = FirebaseFirestore.instance
        .collection('Favorites')
        .where("user_name", isEqualTo: userName)
        .snapshots(includeMetadataChanges: true);

    return StreamBuilder<QuerySnapshot>(
      stream: favDB,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        String userName = Provider.of<userData>(context, listen: false).name;
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        //list에 쌓이는 것 방지 clear로 초기화.
        parkinglot.clear();
        for (var doc in snapshot.data!.docs) {
          // ParkingLotItem
          // String name;
          // String address;
          // String telephone;
          // int minute;
          // int fee;
          // int total_space;
          // int code;
          // bool favorite;
          // int weekday_begin;
          // int weekday_end;
          // int weekend_begin;
          // int weekend_end;
          parkinglot.add(ParkingLotItem(
              doc["name"],
              doc["address"],
              doc["telephone"],
              doc["minute"],
              doc["fee"],
              doc["total_space"],
              doc["code"],
              false,
              doc["weekday_begin"],
              doc["weekday_end"],
              doc["weekend_begin"],
              doc["weekend_end"]));
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
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                child: Card(
                  child: ListTile(
                    onTap: () {},
                    subtitle:
                        // Column(
                        //           crossAxisAlignment: CrossAxisAlignment.stretch,

                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.close),
                            //   iconSize: 15,
                            // ),
                            // SizedBox(width: 10),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(parkinglot[index].name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Text(parkinglot[index].address),
                                  Text(parkinglot[index].telephone),
                                ]),
                            //SizedBox(width: 120),
                            IconButton(
                              padding: EdgeInsets.only(top: 5),
                              constraints: BoxConstraints(),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Favorites")
                                    .doc(
                                        parkinglot[index].name + '_' + userName)
                                    .delete();
                              },
                              icon: Icon(Icons.close),
                              iconSize: 20,
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
                            Provider.of<parkingLotData>(context, listen: false)
                                .lotEdit(parkinglot[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DateTimeSelection()));
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: blue,
                              minimumSize: Size(350, 20)),
                          child: const Text('예약하기',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    // ],
                    // )
                    // ],
                  ),
                ),
                // --- 이미지 넣기 ---
                // ),
              );
            },
          ),
        ));
      },
    );
  }
}

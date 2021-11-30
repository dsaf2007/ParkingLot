import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import '../models/reservation_item.dart';
import '../util/colors.dart';
import 'package:parkinglot/providers/parkinglotdata.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:provider/provider.dart';

class CheckReservation extends StatefulWidget {
  final userId;
  CheckReservation({@required this.userId}) : super();
  @override
  State<CheckReservation> createState() => _CheckReservationState();
}

class _CheckReservationState extends State<CheckReservation> {
  List<ReservationItem> past_reservationlist = [];
  List<ReservationItem> current_reservationlist = [];

  @override
  Widget build(BuildContext context) {
    var historyList;
    CollectionReference reservationDB =
        FirebaseFirestore.instance.collection('Reservation');
    String userName = Provider.of<userData>(context, listen: false).name;

    return FutureBuilder<QuerySnapshot>(
        future: reservationDB.where('user_id', isEqualTo: userName).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Sth Wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            past_reservationlist.clear();
            current_reservationlist.clear();
            //Past / Current ReservationList에 DB에서 불러온 data 삽입-------
            //minute 임시
            int tempMin = 50;
            for (var doc in snapshot.data!.docs) {
              String fee = doc["fee_for_pay"].toString();
              String space = doc["total_space"].toString();
              if (doc["is_current"] == false) {
                past_reservationlist.add(ReservationItem(
                  ParkingLotItem(
                    doc["name"],
                    doc["address"],
                    doc["number"],
                    tempMin,
                    doc["fee"],
                    doc["total_space"],
                    doc["code"],
                    true,
                    doc["weekday_begin_time"],
                    doc["weekday_end_time"],
                    doc["weekend_begin_time"],
                    doc["weekend_end_time"],
                  ),
                  doc["date"],
                  fee,
                  doc["start_time"],
                  doc["end_time"],
                ));
              } else {
                current_reservationlist.add(ReservationItem(
                  ParkingLotItem(
                      doc["name"],
                      doc["address"],
                      doc["number"],
                      tempMin,
                      doc["fee"],
                      doc["total_space"],
                      doc["code"],
                      true,
                      doc["weekday_begin_time"],
                      doc["weekday_end_time"],
                      doc["weekend_begin_time"],
                      doc["weekend_end_time"]),
                  doc["date"],
                  fee,
                  doc["start_time"],
                  doc["end_time"],
                ));
              }
            }
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                title: Text('예약 내역 확인',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                centerTitle: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              body: DefaultTabController(
                  length: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: TabBar(
                          indicatorColor: Colors.black54,
                          indicatorWeight: 4,
                          //밑줄 길이
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black54,
                          tabs: [
                            Tab(text: '과거 예약 내역'),
                            Tab(text: '현재 예약 내역'),
                          ],
                        )),
                        Container(
                          height: 530, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(
                            children: <Widget>[
                              Container(
                                // 과거 예약 내역
                                child: Center(
                                    child: ListView.builder(
                                  itemCount: past_reservationlist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 1.0),
                                        child: Card(
                                          child: ListTile(
                                            onTap: () {},
                                            subtitle: Column(children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      'lib/images/park.png',
                                                      width: 100,
                                                      height: 100),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            past_reservationlist[
                                                                    index]
                                                                .parkingLotItem
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            past_reservationlist[
                                                                    index]
                                                                .parkingLotItem
                                                                .address),
                                                        Text(
                                                            past_reservationlist[
                                                                    index]
                                                                .parkingLotItem
                                                                .telephone),
                                                        Text(
                                                            past_reservationlist[
                                                                    index]
                                                                .date),
                                                        Text(past_reservationlist[
                                                                    index]
                                                                .start_time +
                                                            '~' +
                                                            current_reservationlist[
                                                                    index]
                                                                .end_time),
                                                        Text(
                                                            past_reservationlist[
                                                                    index]
                                                                .total_fee),
                                                      ]),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                            ]),
                                            // --- 이미지 넣기 ---
                                          ),
                                        ));
                                  },
                                )),
                              ),
                              Container(
                                // 현재 예약 내역
                                child: Center(
                                    child: ListView.builder(
                                  itemCount: current_reservationlist.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 1.0),
                                        child: Card(
                                          child: ListTile(
                                            onTap: () {},
                                            subtitle: Column(children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                      'lib/images/park.png',
                                                      width: 100,
                                                      height: 100),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            current_reservationlist[
                                                                    index]
                                                                .parkingLotItem
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            current_reservationlist[
                                                                    index]
                                                                .parkingLotItem
                                                                .address),
                                                        Text(
                                                            current_reservationlist[
                                                                    index]
                                                                .parkingLotItem
                                                                .telephone),
                                                        Text(
                                                            current_reservationlist[
                                                                    index]
                                                                .date),
                                                        Text(current_reservationlist[
                                                                    index]
                                                                .start_time +
                                                            '~' +
                                                            current_reservationlist[
                                                                    index]
                                                                .end_time),
                                                        Text(
                                                            current_reservationlist[
                                                                        index]
                                                                    .total_fee +
                                                                '원'),
                                                      ]),
                                                  SizedBox(height: 20),
                                                  SizedBox(width: 25),
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {},
                                                    icon: Icon(Icons.close),
                                                  ),
                                                  // Image.asset('lib/images/park.png',
                                                  //     width: 100, height: 100),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              TextButton(
                                                // onPressed: () {
                                                //   Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(builder: (context) => FixProfileCKPW()
                                                //     )
                                                //   );
                                                // },
                                                onPressed: () {
                                                  // ParkingLot Provider의 lotData 수정. 예약 확정 시 사용----------------
                                                  Provider.of<parkingLotData>(
                                                          context,
                                                          listen: false)
                                                      .lotEdit(
                                                          current_reservationlist[
                                                                  index]
                                                              .parkingLotItem);
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
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ]),
                                            // --- 이미지 넣기 ---
                                          ),
                                        ));
                                  },
                                )),
                              ),
                            ],
                          ),
                        ),
                      ])),
              bottomNavigationBar:
                  NaviBarButtons(MediaQuery.of(context).size, context),
            ));
          }
          return CircularProgressIndicator();
        });
  }
}

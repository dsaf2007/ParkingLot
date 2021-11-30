import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/models/reservation_item.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
import 'package:parkinglot/providers/customerdata.dart';
import 'package:parkinglot/util/helper.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'package:parkinglot/util/colors.dart';
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
  List<ReservationItem> pastReservationList = [];
  List<ReservationItem> currentReservationList = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Size doubleButtonSize = Size(size.width * 0.4, 20);

    var historyList;
    CollectionReference reservationDB =
        FirebaseFirestore.instance.collection('Reservation');
    bool user_isAdmin = Provider.of<userData>(context, listen: false).isAdmin;
    String user_userName = Provider.of<userData>(context, listen: false).name;
    bool customer_isAdmin =
        Provider.of<customerData>(context, listen: false).isAdmin;
    String customer_userName =
        Provider.of<customerData>(context, listen: false).name;
    bool isAdmin;
    String userName;

    if (user_isAdmin == true) {
      isAdmin = customer_isAdmin;
      userName = customer_userName;
    } else {
      isAdmin = user_isAdmin;
      userName = user_userName;
    }

    return FutureBuilder<QuerySnapshot>(
        future: reservationDB.where('user_id', isEqualTo: userName).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Sth Wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            pastReservationList.clear();
            currentReservationList.clear();
            //Past / Current ReservationList에 DB에서 불러온 data 삽입-------

            int tempMin = 50;
            int time = 900;
            for (var doc in snapshot.data!.docs) {
              String fee = doc["fee_for_pay"].toString();
              String space = doc["total_space"].toString();
              if (doc["is_current"] == false) {
                //             ReservationItem(this.parkingLotItem, this.date, this.start_time,
                // this.end_time, this.total_fee, this.is_current);
                pastReservationList.add(ReservationItem(
                    ParkingLotItem(
                      doc["name"],
                      doc["address"],
                      doc["number"],
                      tempMin,
                      doc["fee"],
                      doc["total_space"],
                      doc["code"],
                      true,
                      time,
                      time,
                      time,
                      time,
                    ),
                    doc["date"],
                    doc["start_time"],
                    doc["end_time"],
                    doc["fee_for_pay"],
                    true,
                    doc["reservation_code"]));
              } else {
                currentReservationList.add(ReservationItem(
                    ParkingLotItem(
                      doc["name"],
                      doc["address"],
                      doc["number"],
                      tempMin,
                      doc["fee"],
                      doc["total_space"],
                      doc["code"],
                      true,
                      time,
                      time,
                      time,
                      time,
                    ),
                    doc["date"],
                    doc["start_time"],
                    doc["end_time"],
                    doc["fee_for_pay"],
                    true,
                    doc["reservation_code"]));
              }
            }
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                title: isAdmin
                    ? Text(userName + "의 예약내역")
                    : Text('예약 내역 확인',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                centerTitle: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              body: DefaultTabController(
                  initialIndex: 1,
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
                                  itemCount: pastReservationList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 1.0),
                                        child: Card(
                                          child: ListTile(
                                            onTap: () {},
                                            subtitle: Column(children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        pastReservationList[
                                                                index]
                                                            .parkingLotItem
                                                            .name,
                                                        style:
                                                            parkingLotNameStyle),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_today,
                                                          color: darkGrey,
                                                          size: 13,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            "${pastReservationList[index].date}, "),
                                                        Text(pastReservationList[
                                                                    index]
                                                                .start_time +
                                                            '~' +
                                                            pastReservationList[
                                                                    index]
                                                                .end_time),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color: darkGrey,
                                                              size: 13,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(pastReservationList[
                                                                    index]
                                                                .parkingLotItem
                                                                .address),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 25,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.phone,
                                                              color: darkGrey,
                                                              size: 13,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(pastReservationList[
                                                                        index]
                                                                    .parkingLotItem
                                                                    .telephone
                                                                    .isEmpty
                                                                ? "전화번호 없음"
                                                                : pastReservationList[
                                                                        index]
                                                                    .parkingLotItem
                                                                    .telephone),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.attach_money,
                                                          color: darkGrey,
                                                          size: 15,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            "${pastReservationList[index].total_fee} 원"),
                                                      ],
                                                    )
                                                  ]),
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
                                  itemCount: currentReservationList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 3.0),
                                        child: Card(
                                          child: ListTile(
                                            onTap: () {},
                                            subtitle: Column(children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        currentReservationList[
                                                                index]
                                                            .parkingLotItem
                                                            .name,
                                                        style:
                                                            parkingLotNameStyle),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_today,
                                                          color: darkGrey,
                                                          size: 13,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            "${currentReservationList[index].date}, "),
                                                        Text(currentReservationList[
                                                                    index]
                                                                .start_time +
                                                            '~' +
                                                            currentReservationList[
                                                                    index]
                                                                .end_time),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color: darkGrey,
                                                              size: 13,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(currentReservationList[
                                                                    index]
                                                                .parkingLotItem
                                                                .address),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 25,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.phone,
                                                              color: darkGrey,
                                                              size: 13,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(currentReservationList[
                                                                        index]
                                                                    .parkingLotItem
                                                                    .telephone
                                                                    .isEmpty
                                                                ? "전화번호 없음"
                                                                : currentReservationList[
                                                                        index]
                                                                    .parkingLotItem
                                                                    .telephone),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.attach_money,
                                                          color: darkGrey,
                                                          size: 15,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            "예상 ${currentReservationList[index].total_fee} 원"),
                                                      ],
                                                    )
                                                  ]),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      // ParkingLot Provider의 lotData 수정. 예약 확정 시 사용----------------
                                                      // todo 아래부분에서 예약취소 해야함
                                                      // Provider.of<parkingLotData>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .lotEdit(
                                                      //         currentReservationList[
                                                      //                 index]
                                                      //             .parkingLotItem);
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             DateTimeSelection()));
                                                    },
                                                    style:
                                                        buildDoubleButtonStyle(
                                                            lightGrey,
                                                            doubleButtonSize),
                                                    child: const Text('예약 취소',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  SizedBox(width: 10),
                                                  TextButton(
                                                    onPressed: () {
                                                      // ParkingLot Provider의 lotData 수정. 예약 확정 시 사용----------------
                                                      Provider.of<parkingLotData>(
                                                              context,
                                                              listen: false)
                                                          .lotEdit(
                                                              currentReservationList[
                                                                      index]
                                                                  .parkingLotItem);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DateTimeSelection()));
                                                    },
                                                    style:
                                                        buildDoubleButtonStyle(
                                                            blue,
                                                            doubleButtonSize),
                                                    child: const Text('예약 수정',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
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

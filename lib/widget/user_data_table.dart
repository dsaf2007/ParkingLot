import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parkinglot/models/user_item.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import '../util/colors.dart';

Widget UserDataTableWidget(BuildContext context) {
  CollectionReference users = FirebaseFirestore.instance.collection('User');

  List<DataColumn> _getColumns = [
    DataColumn(
      label: Text(
        'No',
        textAlign: TextAlign.center,
      ),
    ),
    DataColumn(
      label: Text(
        '고객명',
        textAlign: TextAlign.center,
      ),
    ),
    DataColumn(
      label: Text(
        '전화번호',
        textAlign: TextAlign.center,
      ),
    ),
    DataColumn(
      label: Text(
        '예약확인',
        textAlign: TextAlign.center,
      ),
    )
  ];

  List<DataRow> userList = [];

  return FutureBuilder<QuerySnapshot>(
      future: users.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // Map<String, dynamic> data =
          //     snapshot.data!.data() as Map<String, dynamic>;
          // this.userName = data['Name'];
          // this.userPhoneNumber = data['User_PhoneNum'];
          int i = 1;
          for (var doc in snapshot.data!.docs) {
            //ParkingLotItem(this.image_path, this.name, this.address, this.telephone,
            // this.minute, this.fee, this.total_space, this.favorite)
            // UserItem(this.name, this.telephone, this.email)
            List<DataCell> cellItem = [];
            cellItem.add(DataCell(Text(i.toString())));
            cellItem.add(DataCell(Text(doc["name"])));
            cellItem.add(DataCell(Text(doc["user_telephone"])));
            cellItem.add(DataCell(TextButton(
              child: const Text("예약확인"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckReservation(userId: doc["name"])),
                );
              },
            )));

            userList.add(DataRow(cells: cellItem));
            i += 1;
          }
          return Container(
              width: 330,
              height: 400,
              child: SingleChildScrollView(
                  child: DataTable(
                headingRowHeight: 40,
                dataRowHeight: 40,
                headingTextStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return lightGrey;
                  },
                ),
                dividerThickness: 2,
                columnSpacing: 20.0,
                columns: _getColumns,
                rows: userList,
              )));
        }
        return CircularProgressIndicator();
      });
}

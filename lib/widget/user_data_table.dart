import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import 'package:parkinglot/pages/loading.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/providers/customerdata.dart';
import 'package:provider/provider.dart';

Widget UserDataTableWidget(BuildContext context) {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('User')
      .snapshots(includeMetadataChanges: true);

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
    ),
  ];

  List<DataRow> userList = [];

  return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          // selectedLocationFirst = '';
          // selectedLocationSecond = '';
          return LoadingPage();
        }
        int i = 1;
        for (var doc in snapshot.data!.docs) {
          List<DataCell> cellItem = [];
          cellItem.add(DataCell(Text(i.toString())));
          cellItem.add(DataCell(Text(doc["name"])));
          cellItem.add(DataCell(Text(doc["user_telephone"])));
          cellItem.add(DataCell(TextButton(
            child: const Text("예약확인"),
            onPressed: () {
              //cutomerData Provider 전송 - check_reservation_admin에서 사용
              Provider.of<customerData>(context, listen: false)
                  .userNameEdit(doc["name"]);
                  if(doc["is_admin"] == "FALSE"){
                    Provider.of<customerData>(context, listen: false)
                  .adminEdit(false);
                  } else{
                    Provider.of<customerData>(context, listen: false)
                  .adminEdit(true);
                  }
              
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
            width: 325,
            height: 410,
            child: SingleChildScrollView(
                child: DataTable(
                    headingRowHeight: 40,
                    dataRowHeight: 40,
                    headingTextStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) {
                        return lightGrey;
                      },
                    ),
                    dividerThickness: 2,
                    columnSpacing: 20.0,
                    columns: _getColumns,
                    rows: userList)));
      });
}

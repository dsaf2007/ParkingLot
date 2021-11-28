import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parkinglot/models/user_item.dart';

class UserDataTableWidget extends StatelessWidget {
  UserDataTableWidget({Key? key}) : super(key: key);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    List<UserItem> userList = [];

    return FutureBuilder<QuerySnapshot>(
        future: users.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container();
          if (snapshot.hasError) {
            return Text("Sth Wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // Map<String, dynamic> data =
            //     snapshot.data!.data() as Map<String, dynamic>;
            // this.userName = data['Name'];
            // this.userPhoneNumber = data['User_PhoneNum'];
            for (var doc in snapshot.data!.docs) {
              //ParkingLotItem(this.image_path, this.name, this.address, this.telephone,
              // this.minute, this.fee, this.total_space, this.favorite)
              // UserItem(this.name, this.telephone, this.email)
              userList.add(
                  UserItem(doc["name"], doc["user_telephone"], doc["user_id"]));
            }
            return DataTable(
              columns: [],
              rows: [],
            );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:parkinglot/pages/edit_profile_checkpassword.dart';
import '../util/colors.dart';
import 'package:parkinglot/util/colors.dart';
import 'edit_profile_checkpassword.dart';

String checkPassword = '';
String CarNum = '';
bool IsAdmin = false;
String Name = '';
String User_ID = '';
String User_Password = '';
String User_PhoneNum = '';

EdgeInsets textFormContentPadding = EdgeInsets.symmetric(
  vertical: 5.0,
  horizontal: 15.0,
);

class FixProfileINFO extends StatefulWidget {
  @override
  _FixProfileINFOState createState() => _FixProfileINFOState();
}

class _FixProfileINFOState extends State<FixProfileINFO> {
  @override
  Widget build(BuildContext context) {
    bool? _ischecked = false;
    return Scaffold(
        appBar: AppBar(
            // 값 전달 받기
            title: Text('회원정보수정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FixProfileCKPW()));
                },
                child: const Icon(Icons.arrow_back))),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Text(
              '회원정보를 입력해주세요.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  Name = text;
                },
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: '이름',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  User_PhoneNum = text;
                },
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  hintText: '전화번호',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  User_ID = text;
                },
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: '아이디(이메일)',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  User_Password = text;
                },
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: '새 비밀번호',
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
                ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: '새 비밀번호 확인',
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
                ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  CarNum = text;
                },
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.car_rental),
                  border: OutlineInputBorder(),
                  hintText: '차량번호',
                )),
          ),
          Center(),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 15, 5),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: blue,
                minimumSize: Size(165, 20),
                padding: const EdgeInsets.all(10.0),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FixProfileINFO()));
              },
              child: const Text('확인', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 5),
        ]));
  }
}

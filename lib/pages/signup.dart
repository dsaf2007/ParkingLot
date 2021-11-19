import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Firebase 연동용
String CarNum = '';
bool IsAdmin = false;
String Name = '';
String User_ID = '';
String User_Password = '';
String User_PhoneNum = '';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    bool? _ischecked = false;
    return Scaffold(
        body: ListView(children: [
      Container(
        padding: EdgeInsets.all(0),
        child: Image.asset('images/logo.PNG'),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Text(
          '회원가입을 위한 정보를 입력해주세요',
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
              icon: const Icon(Icons.password),
              border: OutlineInputBorder(),
              hintText: '비밀번호',
            )),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              icon: const Icon(Icons.password),
              border: OutlineInputBorder(),
              hintText: '비밀번호 확인',
            )),
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
              icon: const Icon(Icons.car_rental),
              border: OutlineInputBorder(),
              hintText: '차량번호',
            )),
      ),
      const Divider(
        color: Colors.grey,
        height: 20,
        thickness: 1,
        indent: 10,
        endIndent: 10,
      ),
      // ----------- 개인정보동의 부분 -----------
      CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text('개인정보 수집 및 이용 동의'),
        value: _ischecked,
        onChanged: (bool? value) {
          setState(() {
            _ischecked = value;
          });
        },
        secondary: IconButton(
          icon: Icon(Icons.arrow_downward),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('개인정보 이용약관'),
              content: const Text(
                policy,
                style: TextStyle(fontSize: 10),
              ),
              //children: Image.asset('lib/images/ga.PNG'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
      ),
      TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        onPressed: () {
          FirebaseFirestore.instance.collection("User").doc(Name).set({
            "CarNum": CarNum,
            "IsAdmin": IsAdmin,
            "Name": Name,
            "User_ID": User_ID,
            "User_Password": User_Password,
            "User_PhoneNum": User_PhoneNum
          });
        },
        child: Text('회원가입', style: TextStyle(color: Colors.white)),
      )
    ]));
  }
}

const policy =
    '1. 개인정보의 수집항목 및 수집방법\n  가. 수집하는 개인정보의 항목\n  1. 수집하는 필수항목\n    - 실명인증정보: 이름, 휴대전화번호, 본인인증\n    - 가입정보: 이름, 전화번호, 아이디(이메일), 비밀번호, 비밀번호 확인, 차량번호\n\n  나. 개인정보 수집방법\n    홈페이지 회원가입을 통한 수집\n\n2. 개인정보의 수집/이용 목적 및 보유/이용 기간\n주차왕파킹에서는 정보주체의 회원 가입일로부터 서비스를 제공하는 기간 동안에 한하여 주차왕파킹 서비스를 이용하기 위한 최소한의 개인정보를 보유 및 이용 하게 됩니다. 회원가입 등을 통해 개인정보의 수집·이용, 제공 등에 대해 동의하신 내용은 언제든지 철회하실 수 있습니다. 회원 탈퇴를 요청하거나 수집/이용목적을 달성하거나 보유/이용기간이 종료한 경우, 사업 폐지 등의 사유발생시 개인 정보를 지체 없이 파기합니다.';

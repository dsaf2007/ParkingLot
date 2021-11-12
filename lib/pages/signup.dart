import 'dart:ui';

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    bool? _ischecked = false;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            child :Image.asset('images/logo.PNG'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20,5,20, 5),
            child :Text('회원가입을 위한 정보를 입력해주세요', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: '이름',
                )
            ),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  hintText: '전화번호',
                )
            ),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: '아이디(이메일)',
                )
            ),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: '비밀번호',
                )
            ),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: '비밀번호 확인',
                )
            ),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.car_rental),
                  border: OutlineInputBorder(),
                  hintText: '차량번호',
                )
            ),
          ),
          const Divider(
            color : Colors.grey,
            height : 20,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          // ----------- 개인정보동의 부분 -----------
          Container(
            padding: EdgeInsets.all(10),
            child :Text('주차왕파킹 서비스약관에 동의해주세요', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          CheckboxListTile(
            title : Text('모두 동의합니다.'),
            subtitle: Text('동의에는 필수 및 선택 목적(광고성 정보수신 포함)에 대한 동의가 포함되어있으며, 선택 목적의 동의를 거부하시는 경우에도 서비스 이용이 가능합니다. '),
            controlAffinity : ListTileControlAffinity.leading,
            value: _ischecked,
            onChanged: (bool? value) {
              setState(() {
                _ischecked = value;
            });},

          ),
         ],
        )
      );
      // This trailing comma makes auto-formatting nicer for build methods.
  }
}


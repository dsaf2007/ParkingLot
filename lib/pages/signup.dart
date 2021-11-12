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
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('개인정보 수집 및 이용 동의'),
            value: _ischecked,
            onChanged: (bool? value) {
              setState(() {
                _ischecked = value;
              });
            },
            secondary:
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () =>
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('개인정보 이용약관'),
                          content: const Text(policy, style: TextStyle(fontSize: 10),),
                          //children: Image.asset('lib/images/ga.PNG'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Cancel'),
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
          )
        ]
      )
    );
  }
}
const policy = '가. 수집하는 개인정보의 항목\n  1. 수집하는 필수항목\n    - 실명인증정보: 이름, 휴대전화번호, 본인인증\n    - 가입정보: 이름, 전화번호, 아이디(이메일), 비밀번호, 비밀번호 확인, 차량번호';



import 'package:flutter/material.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/util/colors.dart';

import 'edit_profile_fixinfo.dart';

String checkPassword = '';

EdgeInsets textFormContentPadding = EdgeInsets.symmetric(
  vertical: 5.0,
  horizontal: 15.0,
);

class FixProfileCKPW extends StatefulWidget {
  @override
  _FixProfileCKPWState createState() => _FixProfileCKPWState();
}

class _FixProfileCKPWState extends State<FixProfileCKPW> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back))),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Text(
              '회원님의 개인정보 보호를 위해 비밀번호를 다시 한 번 입력해주세요.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                checkPassword = text;
              },
              decoration: InputDecoration(
                hintText: '비밀번호를 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 20, 5),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Center(),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: lightGrey,
                minimumSize: Size(165, 20),
                padding: const EdgeInsets.all(10.0),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyPage()));
              },
              child: const Text('취소', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 5),
            TextButton(
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
            SizedBox(height: 5),
          ])
        ],
      ),
    );
  }
}

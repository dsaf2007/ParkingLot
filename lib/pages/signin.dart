import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkinglot/pages/home.dart';

import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/providers/parkinglotdata.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:provider/provider.dart';

EdgeInsets textFormContentPadding = EdgeInsets.symmetric(
  vertical: 5.0,
  horizontal: 15.0,
);

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String enterID = '123'; //Initialize용 임시값
  int enterPW = 123;

  _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildBody() {
    return Scaffold(
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/images/logo.PNG'),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (text) {
                  enterID = text; //Onchanged로 ID 저장
                },
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: '이메일 입력',
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  RegExp regex = new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                  return (!regex.hasMatch(value!))
                      ? '이메일 형식을 지켜서 작성해주세요.'
                      : null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (text) {
                  int pw = int.parse(text);
                  enterPW = pw; //Onchanged로 PW 저장
                },
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: textFormContentPadding,
                  icon: const Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: '비밀번호 입력',
                ),
                controller: passwordController,
                obscureText: true,
                validator: (String? value) {
                  return (value!.length < 8) ? '비밀번호는 8자리 이상이여야 합니다.' : null;
                },
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: TextButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  try {
                    //---------------로그인하여 Provider로 User Data 전송/main페이지로 날아가기--------------
                    await FirebaseFirestore.instance
                        .collection('User')
                        .where('user_id', isEqualTo: enterID)
                        .get()
                        .then((QuerySnapshot snapshot) {
                      for (var doc in snapshot.docs) {
                        int passwd = doc["user_password"];
                        if (enterPW == passwd) {
                          if (doc["is_admin"].compareTo("FALSE") == 0) {
                            Provider.of<userData>(context, listen: false)
                                .adminEdit(false);
                          } else {
                            Provider.of<userData>(context, listen: false)
                                .adminEdit(true);
                          }
                          //Provider로 isAdmin 외 Data 받아오는 Part
                          Provider.of<userData>(context, listen: false)
                              .userNameEdit(doc["name"]);
                          Provider.of<userData>(context, listen: false)
                              .userPwEdit(doc["user_password"]);
                          Provider.of<userData>(context, listen: false)
                              .userIdEdit(doc["user_id"]);
                          Provider.of<userData>(context, listen: false)
                              .userTelEdit(doc["user_telephone"]);
                          Provider.of<userData>(context, listen: false)
                              .carNumEdit(doc["car_num"]);

                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {}
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: Text('로그인', style: TextStyle(color: Colors.white)),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(onPressed: () {}, child: const Text('아이디 찾기')),
              TextButton(onPressed: () {}, child: const Text('비밀번호 찾기')),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text('회원가입')),
            ]),
          ],
        ),
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, body: _loading ? _buildLoading() : _buildBody());
  }
}

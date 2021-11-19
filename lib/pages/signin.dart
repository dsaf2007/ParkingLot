import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
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
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
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
                    setState(() => _loading = true);
                    /*
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                       */
                    Navigator.pushReplacementNamed(context, '/auth');
                  } catch (e) {
                    print(e);
                  } finally {
                    setState(() => _loading = false);
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

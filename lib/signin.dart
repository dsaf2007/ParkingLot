import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : <Widget> [
            Image.asset('images/logo.PNG'),
            SizedBox(height: 40),
            Padding(
              padding : EdgeInsets.all(15.0),
              child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon : const Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: '이메일 입력',
                  )
              ),
            ),
            Padding(
              padding : EdgeInsets.all(15.0),
              child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon : const Icon(Icons.password),
                  border: OutlineInputBorder(),
                  hintText: '비밀번호 입력',
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor : 0.9,
              child: TextButton(
                onPressed: () {  },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: Text('로그인', style: TextStyle(color: Colors.white)),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  TextButton(
                      onPressed: () {  },
                      child: const Text('아이디 찾기')
                  ),
                  TextButton(
                      onPressed: () {  },
                      child: const Text('비밀번호 찾기')
                  ),
                  TextButton(
                      onPressed: () {  },
                      child: const Text('회원가입')
                  ),
                ]),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


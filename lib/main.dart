import 'package:flutter/material.dart';
import './splash.dart';
import './signin.dart';
import './signup.dart';
import './search.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
        // const SplashPage(title: 'splash'),
        // const SignInPage(title: 'signin'),
        // const SignUpPage(title: 'signup'),
        const SearchPage(title: 'search')
    );
  }
}

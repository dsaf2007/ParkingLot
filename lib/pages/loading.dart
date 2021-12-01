/// Flutter code sample for CircularProgressIndicator

// This example shows a [CircularProgressIndicator] with a changing value.

import 'package:flutter/material.dart';


/// This is the stateful widget that the main application instantiates.
class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

/// This is the private State class that goes with LoadingPage.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Loading',
            ),
          ],
        ),
      ),
    );
  }
}
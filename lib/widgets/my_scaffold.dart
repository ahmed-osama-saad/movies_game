import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final Widget sheet;

  MyScaffold({@required this.body, this.sheet});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff140F0F),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff140F0F),
          toolbarHeight: 64,
          actions: [
            Image(
              image: AssetImage('assets/logo.png'),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: body,
        ),
        bottomSheet: sheet,
      ),
    );
  }
}

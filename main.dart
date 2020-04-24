import 'package:flutter/material.dart';
import 'package:recommend/presentation/login.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Welcome to Flutter',
      home: Scaffold(
        // appBar: AppBar(
          // title: Text('Welcome to Flutter'),
        // ),
        body: LoginPage(),
        ),
      );
  }
}
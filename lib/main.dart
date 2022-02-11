import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //세로방향 변경 방지
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '다너다너',
      theme: ThemeData(
          //primaryColor: Colors.brown,
          ),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

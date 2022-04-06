import 'dart:io';

import 'package:WordWord/models/recent_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import './models/app_model.dart';
import 'models/word.dart';
import 'screens/home_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main에서 비동기 메소드 사용시 필요

  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  Hive.registerAdapter(wordtestAdapter());
  Hive.registerAdapter(RecentWordAdapter());
  await Hive.openBox<wordtest>('words');
  await Hive.openBox<RecentWord>('RecentWords');

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: const MyApp(),
    ),
  );
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
          fontFamily: 'KoPubBatang',
          //primaryColor: Colors.black,
        ),
        home: AnimatedSplashScreen(
          duration: 100,
          splash: const Hero(
            tag: 'logo',
            child:
                Image(image: AssetImage('assets/launcher_icon/mainLogo.png')),
          ),
          splashTransition: SplashTransition.scaleTransition,
          curve: Curves.fastLinearToSlowEaseIn,
          pageTransitionType: PageTransitionType.fade,
          splashIconSize: 100,
          nextScreen: const HomeScreen(),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

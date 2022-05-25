import 'dart:io';

import 'package:word_word/models/recent_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:word_word/providers/hive_service.dart';
import 'models/word.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../screens/home_screen.dart';
import '../models/app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main에서 비동기 메소드 사용시 필요
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  Hive.registerAdapter(wordtestAdapter());
  Hive.registerAdapter(RecentWordAdapter());
  await Hive.openBox<wordtest>('words');
  await Hive.openBox<RecentWord>('RecentWords');
  //await Hive.openBox<Write>('Writes');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HiveService()),
    ChangeNotifierProvider(create: (context) => AppModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '다너다너',
        theme: ThemeData(
          fontFamily: 'KoPubBatang',
          primaryColor: const Color(0x5fa1df6e),
          primaryColorDark: const Color(0xff0a3711),
          primaryColorLight: const Color(0xfff4ffeb),
          // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x5fa1df6e)),
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
            child: child!,
          );
        },
        // routes: {
        //   '/0': (context) => const Home(),
        //   '/1': (context) => const StorageScreen(),
        //   '/2': (context) => const InfoScreen(),
        // },
        home: AnimatedSplashScreen(
          duration: 100,
          splash: const Image(image: AssetImage('assets/launcher_icon/mainLogo.png')),
          splashTransition: SplashTransition.fadeTransition,
          //curve: Curves.fastLinearToSlowEaseIn,
          pageTransitionType: PageTransitionType.fade,
          splashIconSize: 60,
          nextScreen: const Home(),
          //backgroundColor: Color(0x5fa1df6e),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

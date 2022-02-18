import 'package:WordWord/models/word_model.dart';
import 'package:WordWord/screens/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/word_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    //Hive.box('word_box').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: PageView(
          //physics: const ClampingScrollPhysics(),
          children: [
            Word(word: ''),
            StorageScreen(),
          ],
        ),
      ),
    );
  }
}

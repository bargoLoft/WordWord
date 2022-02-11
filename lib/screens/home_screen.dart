import 'package:flutter/material.dart';
import '../widgets/word_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      body: PageView(
        //physics: const ClampingScrollPhysics(),
        children: [
          Word(word: ''),
        ],
      ),
    );
  }
}

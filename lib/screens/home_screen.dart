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
          scrollDirection: Axis.vertical,
          //physics: const ClampingScrollPhysics(),
          children: [
            Word(word: ''),
            const StorageScreen(),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.grey.shade500,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white.withOpacity(.60),
      //   selectedFontSize: 14,
      //   unselectedFontSize: 14,
      //   currentIndex: _selectedIndex, //현재 선택된 Index
      //   onTap: (int index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       label: '다',
      //       icon: Icon(Icons.search),
      //     ),
      //     BottomNavigationBarItem(
      //       label: '너',
      //       icon: Icon(Icons.storage),
      //     ),
      //     BottomNavigationBarItem(
      //       label: '다너',
      //       icon: Icon(Icons.info),
      //     ),
      //   ],
      // ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:word_word/providers/hive_service.dart';
import 'package:word_word/screens/write_screen.dart';

import 'package:word_word/screens/info_screen.dart';
import 'package:word_word/screens/search_screen.dart';
import 'package:word_word/screens/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final _scrollController = ScrollController();
  int _selectedIndex = 0;
  DateTime? currentBackPressTime;
  //static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   HomeScreen(),
  //   StorageScreen(),
  //   WriteScreen(),
  //   InfoScreen(),
  // ];
  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Theme.of(context).primaryColorDark,
        fontSize: 12.0,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        webShowClose: false,
      );
      return false;
    }
    return true;
  }

  void _onItemTapped(int index) {
    HapticFeedback.lightImpact();
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드 밀려오는거 무시
      appBar: AppBar(
        backgroundColor: _selectedIndex >= 0 ? Theme.of(context).primaryColor : Colors.white,
        elevation: 0.0,
        toolbarHeight: 0.0, // Hide the AppBar
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool result = onWillPop();
          return await Future.value(result);
        },
        child: Center(
          child: Consumer<HiveService>(
            builder: (context, hiveService, child) => IndexedStack(
              index: _selectedIndex,
              children: const [
                HomeScreen(),
                StorageScreen(),
                WriteScreen(),
                InfoScreen(),
              ],
            ),
          ),
        ),
      ),
      //_widgetOptions.elementAt(_selectedIndex),
      // ),

      //_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.095,
        child: BottomNavigationBar(
          iconSize: 23,
          items: <BottomNavigationBarItem>[
            buildBottomNavigationBarItem(icon: const Icon(FontAwesomeIcons.house), label: 'home'),
            buildBottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.boxArchive), label: 'storage'),
            buildBottomNavigationBarItem(icon: const Icon(FontAwesomeIcons.pen), label: 'write'),
            buildBottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.circleInfo), label: 'info'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Colors.black26,
          selectedFontSize: 3.0,
          unselectedFontSize: 3.0,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.0),
          //landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        ),
      ),
      //extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({Icon? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
      label: '',
    );
  }
}

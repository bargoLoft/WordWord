import 'package:word_word/screens/write_screen.dart';

import 'package:word_word/screens/info_screen.dart';
import 'package:word_word/screens/search_screen.dart';
import 'package:word_word/screens/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   HomeScreen(),
  //   StorageScreen(),
  //   InfoScreen(),
  // ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            _selectedIndex >= 0 ? Theme.of(context).primaryColor : Colors.white,
        elevation: 0.0,
        toolbarHeight: 0.0, // Hide the AppBar
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          StorageScreen(),
          WriteScreen(),
          InfoScreen(),
        ],
      ),

      //_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        child: BottomNavigationBar(
            iconSize: 23,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.boxArchive), label: 'storage'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.pen), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.circleInfo), label: 'info'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).primaryColorDark,
            unselectedItemColor: Colors.black26,
            selectedFontSize: 1.0,
            unselectedFontSize: 1.0,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: const Color(0x00ffffff)),
      ),
      //extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}

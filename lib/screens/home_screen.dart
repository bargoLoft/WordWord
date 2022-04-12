import 'dart:io';

import 'package:flutter/services.dart';

import 'package:WordWord/screens/info_screen.dart';
import 'package:WordWord/screens/search_screen.dart';
import 'package:WordWord/screens/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/word_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    StorageScreen(),
    InfoScreen(),
  ];

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        child: BottomNavigationBar(
          iconSize: 25,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.storage), label: 'storage'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'info'),
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
        ),
      ),
    );
  }
}

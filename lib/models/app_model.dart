import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AppModel extends ChangeNotifier {
  bool _autoFocus = false;
  bool _method = true;
  bool _left = false;
  //final mediaQuery = MediaQuery.of().;
  //ScrollController searchScrollController = ScrollController();

  setAutoFocus(bool focus) async {
    final prefs = await SharedPreferences.getInstance();
    _autoFocus = focus;
    prefs.setBool('autoFocus', focus);
  }

  getAutoFocus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('autoFocus') ?? false;
  }

  void setMethod(bool method) async {
    final prefs = await SharedPreferences.getInstance();
    _method = method;
    prefs.setBool('method', method);
  }

  void setLeft(bool left) async {
    final prefs = await SharedPreferences.getInstance();
    _left = left;
    prefs.setBool('left', left);
  }

  void loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('autoFocus') != null) {
      _autoFocus = prefs.getBool('autoFocus')!;
    } else {
      prefs.setBool('autoFocus', false);
    }
    if (prefs.getBool('method') != null) {
      _method = prefs.getBool('method')!;
    } else {
      prefs.setBool('method', true);
    }
    if (prefs.getBool('left') != null) {
      _left = prefs.getBool('left')!;
    } else {
      prefs.setBool('left', false);
    }
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}

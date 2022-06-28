import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AppModel with ChangeNotifier {
  bool _autoFocus;
  bool _method;
  bool _left;

  AppModel(
    this._autoFocus,
    this._method,
    this._left,
  );
  bool getAutoFocus() => _autoFocus;
  bool getMethod() => _method;
  bool getLeft() => _left;

  setAutoFocus(bool focus) async {
    final prefs = await SharedPreferences.getInstance();
    _autoFocus = focus;
    prefs.setBool('autoFocus', focus);
  }
  //
  // void getAutoFocus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('autoFocus') ?? false;
  // }

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

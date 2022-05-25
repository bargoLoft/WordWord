import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModel extends ChangeNotifier {
  bool _autoFocus = false;
  bool _method = true;
  //final mediaQuery = MediaQuery.of().;
  //ScrollController searchScrollController = ScrollController();

  void setAutoFocus(bool focus) async {
    final prefs = await SharedPreferences.getInstance();
    _autoFocus = focus;
    prefs.setBool('autoFocus', focus);
    notifyListeners();
  }

  void setMethod(bool method) async {
    final prefs = await SharedPreferences.getInstance();
    _method = method;
    prefs.setBool('method', method);
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
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}

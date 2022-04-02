import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/setting_screen.dart';

class AppModel extends ChangeNotifier {
  bool autoFocus = false;

  void setAutoFocus(bool focus) async {
    final prefs = await SharedPreferences.getInstance();
    autoFocus = focus;
    prefs.setBool('autoFocus', focus);
    notifyListeners();
  }

  void loadSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    autoFocus = prefs.getBool('autoFocus') ?? false;
  }

  void update() {
    notifyListeners();
  }
}

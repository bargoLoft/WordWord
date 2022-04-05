import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_model.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool autoFocus = false;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      autoFocus = prefs.getBool('autoFocus') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text('설정'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '앱 시작시 바로 검색',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    CupertinoSlidingSegmentedControl(
                      padding: const EdgeInsets.all(4),
                      groupValue: autoFocus,
                      children: const {
                        true: Text('네'),
                        false: Text('아니요'),
                      },
                      onValueChanged: <bool>(newValue) {
                        setState(() {
                          autoFocus = newValue;
                          appModel.setAutoFocus(newValue);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

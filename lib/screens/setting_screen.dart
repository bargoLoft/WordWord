import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_word/models/app_model.dart';

import '../providers/hive_service.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _autoFocus = false;
  String _method = 'exact';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    //context.read<AppModel>().loadSharedPrefs();
    _loadCounter();
  }

  _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _autoFocus = _prefs.getBool('autoFocus') ?? false;
      _method = _prefs.getString('method') ?? 'exact';
    });
    print('$_autoFocus $_method');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text('설정'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
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
                    IgnorePointer(
                      child: CupertinoSlidingSegmentedControl(
                        padding: const EdgeInsets.all(4),
                        groupValue: _autoFocus,
                        children: const {
                          true: Text('네'),
                          false: Text('아니요'),
                        },
                        onValueChanged: <bool>(newValue) {
                          setState(() {
                            _autoFocus = newValue;
                            _prefs.setBool('autoFocus', _autoFocus);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '단어 검색 조건',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    IgnorePointer(
                      child: CupertinoSlidingSegmentedControl(
                        padding: const EdgeInsets.all(4),
                        groupValue: _method,
                        children: const {
                          'exact': Text('일치'),
                          'include': Text('포함'),
                        },
                        onValueChanged: <bool>(newValue) {
                          setState(() {
                            _method = newValue;
                            _prefs.setString('method', _method);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

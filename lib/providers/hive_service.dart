import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:word_word/boxes.dart';
import 'dart:collection';

import '../models/word.dart';
import '../boxes.dart';

class HiveService extends ChangeNotifier {
  List<wordtest> _words = WordBoxes.getWords().values.toList();
  UnmodifiableListView<wordtest> get words => UnmodifiableListView(_words);

  final String wordHiveBox = 'words';

  Future<void> createItem(wordtest word) async {
    Box<wordtest> box = await Hive.openBox<wordtest>(wordHiveBox);
    await box.add(word);
    _words.add(word);
    _words = box.values.toList();

    notifyListeners();
  }

  Future<wordtest> getFirstItems() async {
    Box<wordtest> box = await Hive.openBox(wordHiveBox);
    _words = box.values.toList();
    _words.sort((b, a) => (a.saveTime ?? '').compareTo(b.saveTime ?? ''));
    return _words.first;
    //notifyListeners();
  }

  Future<void> getItems() async {
    Box<wordtest> box = await Hive.openBox(wordHiveBox);
    _words = box.values.toList();
    notifyListeners();
  }

  Future<void> updateItem(String key, wordtest word) async {
    Box<wordtest> box = await Hive.openBox<wordtest>(wordHiveBox);
    box.put(key, word);
    notifyListeners();
  }

  Future<void> deleteItem(String key) async {
    Box<wordtest> box = await Hive.openBox(wordHiveBox);
    await box.delete(key);
    notifyListeners();
  }

  Future<void> sortItem() async {
    _words.sort((b, a) => (a.saveTime ?? '').compareTo(b.saveTime ?? ''));
  }
}

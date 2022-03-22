import 'package:hive/hive.dart';
import 'package:WordWord/models/word.dart';
import 'package:WordWord/models/recent_word.dart';

class WordBoxes {
  static Box<wordtest> getWords() => Hive.box<wordtest>('words');
}

class RecentWordBoxes {
  static Box<RecentWord> getWords() => Hive.box<RecentWord>('RecentWords');
}

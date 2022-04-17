import 'package:hive/hive.dart';
import 'package:word_word/models/word.dart';
import 'package:word_word/models/recent_word.dart';

class WordBoxes {
  static Box<wordtest> getWords() => Hive.box<wordtest>('words');
}

class RecentWordBoxes {
  static Box<RecentWord> getWords() => Hive.box<RecentWord>('RecentWords');
}

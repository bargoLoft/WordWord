import 'package:hive/hive.dart';
import 'package:WordWord/models/word.dart';

class Boxes {
  static Box<Word> getWords() => Hive.box<Word>('words');
}

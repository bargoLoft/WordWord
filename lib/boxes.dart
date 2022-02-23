import 'package:hive/hive.dart';
import 'package:WordWord/models/word.dart';

class Boxes {
  static Box<wordtest> getWords() => Hive.box<wordtest>('words');
}

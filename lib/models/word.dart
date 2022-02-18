import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  String word;
  @HiveField(1)
  int supNo;
  @HiveField(2)
  String pos;
  @HiveField(3)
  String definition;

  Word(
    this.word,
    this.supNo,
    this.pos,
    this.definition,
  );
}

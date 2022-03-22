import 'package:hive/hive.dart';

part 'recent_word.g.dart';

@HiveType(typeId: 1)
class RecentWord extends HiveObject {
  @HiveField(0)
  String word;
  @HiveField(1)
  String time;
  @HiveField(4)
  String targetCode;

  RecentWord(
    this.word,
    this.time,
    this.targetCode,
  );
}

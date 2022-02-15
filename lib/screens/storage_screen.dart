import 'package:flutter/material.dart';
import 'package:WordWord/widgets/word_chip.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              WordChip(word: '붙들'),
              WordChip(word: '수'),
              WordChip(word: '없는'),
              WordChip(word: '꿈의'),
              WordChip(word: '조각들은'),
              WordChip(word: '하나 둘 사라져 가고'),
              WordChip(word: '쳇바퀴'),
              WordChip(word: '돌듯'),
              WordChip(word: '끝이'),
              WordChip(word: '없는'),
              WordChip(word: '방황에'),
              WordChip(word: '오늘도'),
              WordChip(word: '매달려 가네'),
              WordChip(word: '거짓인'),
              WordChip(word: '줄'),
              WordChip(word: '알면서도'),
              WordChip(word: '겉으로'),
              WordChip(word: '감추며'),
              WordChip(word: '한숨섞인'),
              WordChip(word: '말'),
              WordChip(word: '한'),
              WordChip(word: '마디에'),
              WordChip(word: '나만의'),
              WordChip(word: '진실'),
              WordChip(word: '담겨'),
              WordChip(word: '있는'),
              WordChip(word: '듯'),
              WordChip(word: '이제와'),
              WordChip(word: '뒤늦게'),
              WordChip(word: '무엇을 더'),
              WordChip(word: '보태려 하나'),
              WordChip(word: '귀 기울여'),
              WordChip(word: '듣지 않고'),
              WordChip(word: '달리 보면'),
              WordChip(word: '그만인 것을'),
            ],
          ),
        ),
      ),
    );
  }
}

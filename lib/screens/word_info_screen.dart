import 'package:WordWord/models/word_view.dart';
import 'package:flutter/material.dart';

class WordView extends StatefulWidget {
  final Item? item;
  const WordView({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${widget.item?.wordInfo?.word}',
                  style: TextStyle(fontSize: 30),
                ),

                Text(
                  '(${widget.item?.wordInfo?.originalLanguageInfo?.first.originalLanguage})',
                  style: TextStyle(fontSize: 20),
                ), // 전부추가요망
              ],
            ),
            Text(
              '발음 [${widget.item?.wordInfo?.pronunciationInfo?.first.pronunciation}]',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '활용 [${widget.item?.wordInfo?.conjuInfo?.first.conjugationInfo?.conjugation ?? ''}]',
              style: TextStyle(fontSize: 20),
            ),
            Text(widget.item?.wordInfo?.posInfo?.first.pos ?? ''),
            Text(widget.item?.wordInfo?.posInfo?.first.commPatternInfo?.first
                    .senseInfo?.first.definition ??
                ''),
            Text(widget.item?.wordInfo?.posInfo?.first.commPatternInfo?.first
                    .senseInfo?.first.exampleInfo?.first.example ??
                ''),
          ],
        ),
      ),
    );
  }
}

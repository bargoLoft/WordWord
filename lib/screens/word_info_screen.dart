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
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.item?.wordInfo?.word}', //단어이름
                        style: TextStyle(fontSize: 30),
                      ),
                      if (widget.item?.wordInfo?.originalLanguageInfo != null)
                        Text(
                          '(${widget.item?.wordInfo?.originalLanguageInfo?.first.originalLanguage})', //영어, 한자표기
                          style: TextStyle(fontSize: 20),
                        ), //
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('발음 ', style: TextStyle(fontSize: 20)),
                      for (var pronunciation
                          in widget.item?.wordInfo?.pronunciationInfo ?? [])
                        Text(
                          '[${pronunciation.pronunciation}]',
                          style: TextStyle(fontSize: 17),
                        ),
                    ],
                  ),
                  if (widget.item?.wordInfo?.conjuInfo != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('활용 ', style: TextStyle(fontSize: 20)),
                        for (var conju
                            in widget.item?.wordInfo?.conjuInfo ?? [])
                          Text(
                            '${conju.conjugationInfo.conjugation}[${conju.conjugationInfo.pronunciationInfo.first.pronunciation}] ',
                            style: TextStyle(fontSize: 17),
                          ),
                      ],
                    ),
                  Text(widget.item?.wordInfo?.posInfo?.first.pos ?? ''), // 품사
                  Column(
                    children: [
                      for (var sense in widget.item?.wordInfo?.posInfo?.first
                              .commPatternInfo?.first.senseInfo ??
                          [])
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${sense.definition}'),
                            for (var example in sense?.exampleInfo ?? [])
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle_notifications_outlined,
                                    size: 10,
                                  ),
                                  Text(
                                    ' ${example.example}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                  if (widget.item?.wordInfo?.origin != null)
                    Text('어원 : ${widget.item?.wordInfo?.origin ?? ''}'),
                  for (var relation
                      in widget.item?.wordInfo?.relationInfo ?? [])
                    Text('관용구/속담: ${relation.relationWord ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

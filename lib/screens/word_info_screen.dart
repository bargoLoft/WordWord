import 'package:WordWord/models/word_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
      body: Scrollbar(
        child: ListView(
          //physics: NeverScrollableScrollPhysics(),
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
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.item?.wordInfo?.word}', //단어이름
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      if (widget.item?.wordInfo?.originalLanguageInfo != null)
                        Row(
                          children: [
                            const Text('(', style: TextStyle(fontSize: 20)),
                            for (var original in widget
                                    .item?.wordInfo?.originalLanguageInfo ??
                                [])
                              AutoSizeText(
                                '${original.originalLanguage}',
                                style: const TextStyle(fontSize: 20),
                              ),
                            const Text(')', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                    ],
                  ),
                  if (widget.item?.wordInfo?.pronunciationInfo != null)
                    const Divider(height: 10),
                  if (widget.item?.wordInfo?.pronunciationInfo != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('발음 ', style: TextStyle(fontSize: 16)),
                        for (var pronunciation
                            in widget.item?.wordInfo?.pronunciationInfo ?? [])
                          Text(
                            '[${pronunciation.pronunciation}]',
                            style: const TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  if (widget.item?.wordInfo?.conjuInfo != null)
                    const Divider(height: 10),
                  if (widget.item?.wordInfo?.conjuInfo != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('활용 ', style: TextStyle(fontSize: 16)),
                        for (var conju
                            in widget.item?.wordInfo?.conjuInfo ?? [])
                          Text(
                            '${conju.conjugationInfo.conjugation}[${conju.conjugationInfo.pronunciationInfo.first.pronunciation}] ',
                            style: const TextStyle(fontSize: 16),
                          ),
                      ],
                    ),
                  const Divider(height: 10),
                  if (widget.item?.wordInfo?.posInfo?.first.pos != '품사 없음')
                    Text(
                      '⌜${widget.item?.wordInfo?.posInfo?.first.pos ?? ''}⌟',
                      style: const TextStyle(fontSize: 15),
                    ), //
                  if (widget.item?.wordInfo?.posInfo?.first.commPatternInfo
                          ?.first.patternInfo !=
                      null) // 품사
                    Text(
                        '【${widget.item?.wordInfo?.posInfo?.first.commPatternInfo?.first.patternInfo?.first.pattern}】'),
                  const SizedBox(height: 3),
                  Column(
                    children: [
                      for (var sense in widget.item?.wordInfo?.posInfo?.first
                              .commPatternInfo?.first.senseInfo ??
                          [])
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (sense?.catInfo != null)
                              Text(
                                '⌜${sense?.catInfo.first.cat ?? ''}⌟ ',
                                style: const TextStyle(fontSize: 15),
                              ),
                            Text(
                              //⌜⌟
                              '${sense.definition}',
                              style: const TextStyle(fontSize: 15),
                            ),
                            for (var example in sense?.exampleInfo ?? [])
                              Text(
                                ' - ${example.example}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            const Divider(height: 10)
                          ],
                        ),
                    ],
                  ),
                  // if (widget.item?.wordInfo?.origin != null)
                  //   Text('어원 : ${widget.item?.wordInfo?.origin ?? ''}'),
                  if (widget.item?.wordInfo?.relationInfo != null)
                    const Text('관용구/속담'),
                  for (var relation
                      in widget.item?.wordInfo?.relationInfo ?? [])
                    Text(' - ${relation.relationWord ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

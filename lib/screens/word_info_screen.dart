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
        child: Scrollbar(
          isAlwaysShown: true,
          child: ListView(
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
                          style: const TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        if (widget.item?.wordInfo?.originalLanguageInfo != null)
                          Text(
                            '(${widget.item?.wordInfo?.originalLanguageInfo?.first.originalLanguage})', //영어, 한자표기
                            style: const TextStyle(fontSize: 25),
                          ), //
                      ],
                    ),
                    if (widget.item?.wordInfo?.pronunciationInfo != null)
                      const Divider(
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                      ),
                    if (widget.item?.wordInfo?.pronunciationInfo != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('발음 ', style: TextStyle(fontSize: 16)),
                          for (var pronunciation
                              in widget.item?.wordInfo?.pronunciationInfo ?? [])
                            Text(
                              '[${pronunciation.pronunciation}]',
                              style: TextStyle(fontSize: 16),
                            ),
                        ],
                      ),
                    if (widget.item?.wordInfo?.conjuInfo != null)
                      const Divider(height: 10, indent: 10, endIndent: 10),
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
                    const Divider(height: 10, indent: 10, endIndent: 10),
                    Text(
                      '⌜${widget.item?.wordInfo?.posInfo?.first.pos ?? ''}⌟',
                      style: TextStyle(fontSize: 18),
                    ), // 품사
                    const SizedBox(height: 3),
                    Column(
                      children: [
                        for (var sense in widget.item?.wordInfo?.posInfo?.first
                                .commPatternInfo?.first.senseInfo ??
                            [])
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '⌜⌟ ${sense.definition}',
                                style: TextStyle(fontSize: 17),
                              ),
                              for (var example in sense?.exampleInfo ?? [])
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      ' - ${example.example}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              const Divider(
                                height: 10,
                                indent: 5,
                                endIndent: 5,
                              )
                            ],
                          ),
                      ],
                    ),
                    // if (widget.item?.wordInfo?.origin != null)
                    //   Text('어원 : ${widget.item?.wordInfo?.origin ?? ''}'),
                    if (widget.item?.wordInfo?.relationInfo != null)
                      Text('관용구/속담'),
                    for (var relation
                        in widget.item?.wordInfo?.relationInfo ?? [])
                      Text(' - ${relation.relationWord ?? ''}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

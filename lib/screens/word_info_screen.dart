import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word_word/boxes.dart';
import 'package:word_word/models/word.dart';
import 'package:word_word/models/word_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:word_word/providers/word_search.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:word_word/providers/hive_service.dart';

import 'package:intl/intl.dart';

class WordViewInfo extends StatefulWidget {
  final Item? item;
  const WordViewInfo({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<WordViewInfo> createState() => _WordViewInfoState();
}

class _WordViewInfoState extends State<WordViewInfo> {
  final Completer<WebViewController> webController = Completer<WebViewController>();
  final ScrollController _scrollController = ScrollController();
  //final StreamController<Object> _streamController = StreamController();
  Widget webView(String url) {
    return WebView(
      initialUrl: url,
      onWebViewCreated: (WebViewController _controller) async {
        webController.isCompleted ? '' : webController.complete(_controller);
      },
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
  //
  // @override
  // void initState()  {
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          //physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();

                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: WordBoxes.getWords().containsKey(widget.item?.targetCode)
                      ? TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            HiveService().deleteItem(widget.item?.targetCode ?? '');
                            showToast('${widget.item?.wordInfo?.word} 제거 했습니다', Colors.red.shade50);
                            setState(() {});
                          },
                          child: Wrap(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              Text(
                                DateFormat('yy/MM/dd')
                                    .format(DateTime.parse((WordBoxes.getWords()
                                                .get(widget.item?.targetCode)
                                                ?.saveTime ??
                                            '')
                                        .substring(0, 8)))
                                    .toString(),
                                style: TextStyle(fontSize: 9, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();

                            HiveService().updateItem(
                                widget.item?.targetCode ?? '',
                                wordtest(
                                    widget.item?.wordInfo?.word ?? '',
                                    0,
                                    widget.item?.wordInfo?.posInfo?[0].pos ?? '',
                                    widget.item?.wordInfo?.posInfo?[0].commPatternInfo?[0]
                                            .senseInfo?[0].definition ??
                                        '',
                                    widget.item?.targetCode ?? '',
                                    DateFormat('yyyyMMddhhmmss').format(DateTime.now()),
                                    null));
                            showToast('${widget.item?.wordInfo?.word} 넣었습니다');
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.item?.wordInfo?.word}', //단어이름
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          //    letterSpacing: 4.0
                        ),
                      ),
                      if (widget.item?.wordInfo?.originalLanguageInfo != null)
                        const SizedBox(width: 2),
                      if (widget.item?.wordInfo?.originalLanguageInfo != null)
                        Row(
                          children: [
                            const Text('(', style: TextStyle(fontSize: 20, color: Colors.grey)),
                            for (var original in widget.item?.wordInfo?.originalLanguageInfo ?? [])
                              AutoSizeText(
                                '${original.originalLanguage}',
                                style: const TextStyle(fontSize: 25, color: Colors.grey),
                              ),
                            const Text(')', style: TextStyle(fontSize: 25, color: Colors.grey)),
                          ],
                        ),
                    ],
                  ),
                  // if (widget.item?.wordInfo?.pronunciationInfo != null)
                  //   const Divider(height: 10),
                  // if (widget.item?.wordInfo?.pronunciationInfo != null)
                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       const Text('발음 ', style: TextStyle(fontSize: 16)),
                  //       for (var pronunciation
                  //           in widget.item?.wordInfo?.pronunciationInfo ?? [])
                  //         Text(
                  //           '[${pronunciation.pronunciation}]',
                  //           style: const TextStyle(fontSize: 16),
                  //         ),
                  //     ],
                  //   ),
                  // if (widget.item?.wordInfo?.conjuInfo != null)
                  //   const Divider(height: 10),
                  // if (widget.item?.wordInfo?.conjuInfo != null)
                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       const Text('활용 ', style: TextStyle(fontSize: 16)),
                  //       for (var conju
                  //           in widget.item?.wordInfo?.conjuInfo ?? [])
                  //         Text(
                  //           '${conju.conjugationInfo.conjugation}[${conju.conjugationInfo.pronunciationInfo.first.pronunciation}] ',
                  //           style: const TextStyle(fontSize: 16),
                  //           //overflow: TextOverflow.fade,
                  //         ),
                  //     ],
                  //   ),
                  // const Divider(height: 1),

                  if (widget.item?.wordInfo?.posInfo?.first.pos != '품사 없음')
                    Text(
                      widget.item?.wordInfo?.posInfo?.first.pos ?? '',
                    ), //
                  if (widget.item?.wordInfo?.posInfo?.first.pos != '품사 없음')
                    const SizedBox(height: 3),
                  for (var comm in widget.item?.wordInfo?.posInfo?.first.commPatternInfo ?? [])
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (comm.patternInfo != null) // 품사
                          Text('【${comm.patternInfo?.first.pattern}】'),
                        if (comm.patternInfo != null) // 품
                          const SizedBox(height: 3),
                        if (comm.grammarInfo != null) // grammar
                          Text('(${comm.grammarInfo?.first.grammar})'),
                        if (comm.grammarInfo != null) const SizedBox(height: 3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var sense in comm.senseInfo ?? [])
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      if (sense?.catInfo != null)
                                        Text(
                                          '『${sense?.catInfo.first.cat ?? ''}』 ',
                                        ),
                                      if (sense?.sensePatternInfo != null)
                                        Text(
                                          '⌜${sense?.sensePatternInfo.first.pattern ?? ''}⌟ ',
                                        ),
                                      if (sense?.senseGrammarInfo != null)
                                        Text(
                                          '(${sense?.senseGrammarInfo.first.grammar ?? ''}) ',
                                        ),
                                    ],
                                  ),
                                  SelectableText(
                                    '${sense.definition}',
                                    toolbarOptions:
                                        const ToolbarOptions(copy: true, selectAll: true),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      height: 1.6,
                                    ),
                                  ),
                                  if (sense?.lexicalInfo != null)
                                    Row(
                                      children: [
                                        const Text('≒'),
                                        for (var lexical in sense?.lexicalInfo ?? [])
                                          GestureDetector(
                                            onTap: () async {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => webView(
                                              //             sense?.lexicalInfo?.first.link)));
                                              String url = lexical.link;
                                              int start = url.indexOf('=') + 1;
                                              int last = url.indexOf('&');
                                              String targetCode = url.substring(start, last);

                                              WordView wordView =
                                                  await getWordViewData(targetCode: targetCode);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => WordViewInfo(
                                                          item: wordView.channel?.item ?? Item())));
                                            },
                                            child: RichText(
                                                text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${lexical.word}',
                                                  style: const TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Color(0xff004912),
                                                      fontFamily: 'KoPubBatang'

                                                      //decoration: TextDecoration.underline
                                                      ),
                                                ),
                                                const TextSpan(text: ' '),
                                              ],
                                            )),
                                          ),
                                      ],
                                    ),
                                  if (sense?.exampleInfo != null) const SizedBox(height: 5),
                                  for (var example in sense?.exampleInfo ?? [])
                                    Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: ' • ${example.example}',
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontFamily: 'KoPubBatang'),
                                              children: <TextSpan>[
                                                if (example.source != null)
                                                  TextSpan(text: ' ≪${example.source}≫')
                                              ]),
                                        ),
                                        const SizedBox(height: 2)
                                      ],
                                    ),
                                  const SizedBox(height: 10),
                                  //const Divider(color: Colors.grey, height: 10),
                                ],
                              ),
                            // const Divider(
                            //   color: Colors.black,
                            //   //thickness: 1,
                            //   height: 10,
                            // )
                          ],
                        ),
                      ],
                    ),
                  if (widget.item?.wordInfo?.relationInfo != null) const Text('관용구/속담'),
                  for (var relation in widget.item?.wordInfo?.relationInfo ?? [])
                    SelectableText(' - ${relation.relationWord ?? ''}'),
                  if (widget.item?.wordInfo?.origin != null)
                    const Divider(color: Colors.grey, height: 10),
                  if (widget.item?.wordInfo?.origin != null)
                    Text('어원 : ${widget.item?.wordInfo?.origin ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String msg, [Color? backgroundColor]) => Fluttertoast.showToast(
        msg: msg,
        //msg: '현재 국립국어원 Open API의 문제로\n 사진 자료가 있는 단어는 상세검색이 되지 않습니다.!',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColorLight,
        textColor:
            backgroundColor != null ? Colors.red.shade500 : Theme.of(context).primaryColorDark,
        fontSize: 13.0,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        webShowClose: false,
      );
}

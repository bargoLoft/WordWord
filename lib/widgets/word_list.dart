import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/word_search.dart';
import '../models/word_model.dart' as search;
import '../models/word_view.dart' as view;
import '../models/word.dart';
import 'package:WordWord/boxes.dart';
import '../screens/info_screen.dart';
import '../screens/word_info_screen.dart';
import '../widgets/word_info.dart';

class Word extends StatefulWidget {
  String word;
  search.WordModel wordModel = search.WordModel();
  List<view.WordView> wordView = [];
  Word({Key? key, required this.word}) : super(key: key);

  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  final _wordSearchController = TextEditingController();
  final _myFocusNode = FocusNode();

  String inputText = '';
  double _logoOpacity = 0.7;
  bool isLoading = true;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    //getWordData(widget.word).whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _myFocusNode.dispose();
    _scrollController.dispose();
    _wordSearchController.dispose();
  }

  Future<void> getWordSearchData(String query) async {
    String wordJson = await WordSearch().getWords(query);
    print('받아오고');
    setState(() {
      if (wordJson.isNotEmpty) {
        widget.wordModel = search.WordModel.fromJson(jsonDecode(wordJson));
      } else {
        const snackBar = SnackBar(
          content: Text('검색 결과가 없습니다!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      isLoading = false;
    });
    List total = widget.wordModel.channel?.total == 1
        ? [0]
        : List.generate(widget.wordModel.channel?.total ?? 0, (i) => i + 1);
    for (var e in total) {
      view.WordView tmp = await getWordViewData(query, e.toString());
      widget.wordView.add(tmp);
    }
    print('변경');
  }

  Future<view.WordView> getWordViewData(String? query, String num) async {
    String wordJsonView = await WordViewSearch().getWords(query!, num);
    print('view받아오고');
    view.WordView wordViewData =
        view.WordView.fromJson(jsonDecode(wordJsonView));
    //isLoading = false;
    print('view변경');
    return wordViewData;
  }

  Future<void> getWordRandomViewData(String num) async {
    String wordJsonView = await WordRandomViewSearch().getWords(num);
    print('받아오고');
    view.WordView wordViewData =
        view.WordView.fromJson(jsonDecode(wordJsonView));
    if (wordViewData.channel == null || wordViewData.channel?.total == 0) {
      var num2 = Random().nextInt(422879);
      await getWordRandomViewData(num2.toString());
    } else {
      String str =
          _textReplace(wordViewData.channel?.item?.wordInfo?.word ?? '');
      getWordSearchData(str);
    }
  }

  String _textReplace(String str) {
    str = str.replaceAll('-', '');
    str = str.replaceAll('^', '');
    return str;
  }
  //
  // Future refresh() async {
  //   setState(() async {
  //     await getWordSearchData('우리');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewPadding,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                          _logoOpacity = 0.0;
                          widget.wordView.clear();
                        });
                        await getWordRandomViewData(Random()
                            .nextInt(422879)
                            .toString()); // 등록단어 수 422879
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Icon(
                        FontAwesomeIcons.random,
                        color: Colors.grey,
                        size: 20,
                      )),
                  const Image(
                    image: AssetImage(
                      'assets/images/다너다너6.png',
                    ),
                    height: 30,
                  ),
                  TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InfoScreen()));
                      },
                      child: const Icon(
                        Icons.info_outlined,
                        color: Colors.grey,
                        size: 25,
                      )),
                ],
              ),
            ),
            Expanded(
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: isLoading == true
                      ? const Center(
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : Scrollbar(
                          isAlwaysShown: true,
                          controller: _scrollController,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              controller: _scrollController,
                              itemCount: widget.wordModel.channel?.total ?? 0,
                              //shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) =>
                                  Dismissible(
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        Boxes.getWords().put(
                                          widget.wordModel.channel?.item![index]
                                                  .targetCode ??
                                              0,
                                          wordtest(
                                            widget.wordModel.channel
                                                    ?.item![index].word ??
                                                '',
                                            int.parse(widget.wordModel.channel
                                                    ?.item![index].supNo ??
                                                ''),
                                            widget.wordModel.channel
                                                    ?.item![index].pos ??
                                                '',
                                            widget
                                                    .wordModel
                                                    .channel
                                                    ?.item![index]
                                                    .sense
                                                    ?.definition ??
                                                '',
                                            widget.wordModel.channel
                                                    ?.item![index].targetCode ??
                                                '',
                                          ),
                                        );
                                        //setState(() {}); 저장시 없앨지
                                      }
                                    },
                                    background: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.green,
                                      alignment: Alignment.centerRight,
                                      child: const Icon(
                                        Icons.save,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    key: UniqueKey(),
                                    // Key(widget.wordModel.channel?.item![index]
                                    //         .word ??
                                    //     ''),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => WordView(
                                                    item: widget.wordView[index]
                                                        .channel?.item)));
                                      },
                                      child: WordInfo(
                                        item: widget.wordModel.channel
                                                ?.item![index] ??
                                            search.Item(),
                                      ),
                                    ),
                                  )),
                        ),
                ),
                IgnorePointer(
                  child: Center(
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        opacity: _logoOpacity,
                        child: const Image(
                          image: AssetImage('assets/images/다너다너3.png'),
                        )),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          FontAwesomeIcons.search,
                          size: 18,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          //제출시 검색되게
                          controller: _wordSearchController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          autofocus: false,
                          focusNode: _myFocusNode,
                          onSubmitted: (String text) {
                            inputText = text;
                            print('입력하신 단어는 $inputText 입니다.');
                            setState(() {
                              _logoOpacity = 0.0;
                              isLoading = true;
                              widget.wordView.clear();
                              getWordSearchData(inputText);
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: '단어를 입력해 주세요',
                            border: InputBorder.none,
                            // suffixIcon:
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _wordSearchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _wordSearchController.clear();
                                FocusScope.of(context)
                                    .requestFocus(_myFocusNode);
                              },
                              splashColor: Colors.transparent,
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

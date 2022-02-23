import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/word_info.dart';
import '../providers/word_search.dart';
import '../models/word_model.dart';
import '../models/word.dart';
import 'package:WordWord/boxes.dart';

class Word extends StatefulWidget {
  String word;
  WordModel wordModel = WordModel();
  Word({Key? key, required this.word}) : super(key: key);

  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  final _scrollController = ScrollController(initialScrollOffset: 50.0);
  final _wordSearchController = TextEditingController();
  final _myFocusNode = FocusNode();

  String inputText = '';
  double _logoOpacity = 0.7;

  @override
  void initState() {
    super.initState();

    //getWordData(widget.word).whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _wordSearchController.dispose();
  }

  Future<void> getWordData(String query) async {
    String wordJson = await WordSearch().getWords(query);
    print('받아오고');
    setState(() {
      widget.wordModel = WordModel.fromJson(jsonDecode(wordJson));
    });
    print('변경');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    showTrackOnHover: true,
                    isAlwaysShown: false,
                    child: ListView.builder(
                        itemCount: widget.wordModel.channel?.total ?? 0,
                        //shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            Dismissible(
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  Boxes.getWords().put(
                                    widget.wordModel.channel?.item![index]
                                        .targetCode,
                                    wordtest(
                                      widget.wordModel.channel?.item![index]
                                              .word ??
                                          '',
                                      int.parse(widget.wordModel.channel
                                              ?.item![index].supNo ??
                                          ''),
                                      widget.wordModel.channel?.item![index]
                                              .pos ??
                                          '',
                                      widget.wordModel.channel?.item![index]
                                              .sense?.definition ??
                                          '',
                                      widget.wordModel.channel?.item![index]
                                              .targetCode ??
                                          '',
                                    ),
                                  );
                                  setState(() {});
                                }
                              },
                              background: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                color: Colors.green,
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.save,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              key: UniqueKey(),
                              // Key(widget.wordModel.channel?.item![index]
                              //         .word ??
                              //     ''),
                              child: WordInfo(
                                item: widget.wordModel.channel?.item![index] ??
                                    Item(),
                              ),
                            )),
                  ),
                ),
                IgnorePointer(
                  child: Center(
                    child: AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: _logoOpacity,
                        child: Image(
                          image: AssetImage('assets/images/국립국어원_국_상하.jpg'),
                        )),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '🔍',
                            style: TextStyle(
                              fontSize: 24,
                            ),
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
                                getWordData(inputText);
                                _logoOpacity = 0.0;
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
            ),
          ],
        ),
      ),
    );
  }
}

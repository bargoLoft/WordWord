import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/word_info.dart';
import '../providers/word_search.dart';
import '../models/word_model.dart';

class Word extends StatefulWidget {
  String word;
  WordModel wordModel = WordModel();
  Word({Key? key, required this.word}) : super(key: key);

  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  final _wordSearchController = TextEditingController();
  String inputText = '';
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
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 다른곳 클릭 시 키보드 off
        },
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: ListView.builder(
                    itemCount: widget.wordModel.channel?.total ?? 0,
                    //shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return WordInfo(
                        item: widget.wordModel.channel?.item![index] ?? Item(),
                      );
                    }),
              ),
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
                            onSubmitted: (String text) {
                              inputText = text;
                              print('입력하신 단어는 $inputText 입니다.');
                              setState(() {
                                getWordData(inputText);
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: '단어를 입력해 주세요',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
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

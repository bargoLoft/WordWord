import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../boxes.dart';
import '../models/recent_word.dart';
import '../widgets/word_list.dart';

class RecentWordList extends StatefulWidget {
  const RecentWordList({Key? key}) : super(key: key);

  @override
  _RecentWordListState createState() => _RecentWordListState();
}

class _RecentWordListState extends State<RecentWordList> {
  String _textReplace(String str) {
    str = str.replaceAll('-', '');
    str = str.replaceAll('^', '');
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최근 검색어'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              child: const Text('전체삭제'),
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () => {RecentWordBoxes.getWords().clear()},
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<RecentWord>>(
        valueListenable: RecentWordBoxes.getWords().listenable(),
        builder: (context, box, _) {
          var words = box.values.toList().cast<RecentWord>();
          words.sort((a, b) => a.time.compareTo(b.time));
          return words.isEmpty
              ? const Center(
                  child: Text(
                  '최근 검색 기록이 없습니다.',
                  style: TextStyle(fontSize: 20),
                ))
              : ListView.builder(
                  itemCount: box.keys.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context, _textReplace(words[words.length - index - 1].word));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                words[words.length - index - 1].word,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormat('yyyy/MM/dd')
                                        .format(DateTime.parse(
                                            words[words.length - index - 1].time.substring(0, 8)))
                                        .toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    constraints: BoxConstraints.tight(const Size(30, 40)),
                                    splashRadius: 1,
                                    iconSize: 20,
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      RecentWordBoxes.getWords()
                                          .delete(words[words.length - index - 1].targetCode);
                                      //_wordSearchController.clear();
                                      //FocusScope.of(context).requestFocus(_myFocusNode);
                                    },
                                    splashColor: Colors.transparent,
                                    icon: const Icon(Icons.clear),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const CustomDivider(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

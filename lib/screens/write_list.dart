import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';
import '../models/word.dart';
import '../widgets/word_list.dart';

class WriteList extends StatefulWidget {
  const WriteList({Key? key}) : super(key: key);

  @override
  State<WriteList> createState() => _WriteListState();
}

class _WriteListState extends State<WriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('작성 목록'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: TextButton(
        //       child: const Text('전체삭제'),
        //       style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.green)),
        //       onPressed: () => {RecentWordBoxes.getWords().clear()},
        //     ),
        //   ),
        // ],
      ),
      body: ValueListenableBuilder<Box<wordtest>>(
        valueListenable: WordBoxes.getWords().listenable(),
        builder: (context, box, _) {
          var words = box.values.toList().cast<wordtest>();
          List writeWords = [];
          words.sort((a, b) => (a.saveTime ?? '').compareTo(b.saveTime ?? ''));
          for (var e in words) {
            if (e.write != null && (jsonDecode(e.write!)[0]['insert'].toString() != '\n')) {
              print(e.write);
              writeWords.add(e);
            }
          }
          writeWords.sort((a, b) => a.saveTime.compareTo(b.saveTime));
          return writeWords.isEmpty
              ? const Center(
                  child: Text(
                  '작성된 글이 없습니다.',
                  style: TextStyle(fontSize: 20),
                ))
              : Scrollbar(
                  child: ListView.builder(
                    itemCount: writeWords.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context,
                                      words.indexOf(writeWords[writeWords.length - index - 1]));
                                  //print(words.indexOf(writeWords[writeWords.length - index - 1]));
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                  elevation: 0.5,
                                  //margin: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          writeWords[writeWords.length - index - 1].word,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (writeWords[writeWords.length - index - 1].supNo == '0')
                                          const SizedBox(width: 1)
                                        else
                                          Container(
                                            height: 25,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              writeWords[writeWords.length - index - 1]
                                                  .supNo
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        if (writeWords[writeWords.length - index - 1].write != null)
                                          Flexible(
                                            child: Text(
                                              jsonDecode(writeWords[writeWords.length - index - 1]
                                                      .write)[0]['insert']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ))),
                        //
                        // RichText(
                        //     textAlign: TextAlign.start,
                        //     text: TextSpan(
                        //         text: writeWords[writeWords.length - index - 1].word,
                        //         style: const TextStyle(
                        //             //fontWeight: FontWeight.bold,
                        //             fontSize: 15,
                        //             color: Color(0xff004912),
                        //             fontFamily: 'KoPubBatang'
                        //             //decoration: TextDecoration.underline
                        //             ),
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: jsonDecode(
                        //                       writeWords[writeWords.length - index - 1]
                        //                           .write)[0]['insert']
                        //                   .toString()),
                        //         ])))),
                        const CustomDivider(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

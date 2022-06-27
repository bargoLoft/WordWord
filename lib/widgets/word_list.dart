import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:word_word/providers/hive_service.dart';

import '../models/word_model.dart';
import '../providers/word_search.dart';
import '../models/word_model.dart' as search;
import '../models/word_view.dart' as view;
import '../models/word.dart';
import '../models/recent_word.dart';
import 'package:word_word/boxes.dart';
import '../screens/word_info_screen.dart';
import '../screens/recent_screen.dart';
import '../widgets/word_info.dart';

// ignore: must_be_immutable
class Word extends StatefulWidget {
  String word;
  search.WordModel wordModel = search.WordModel();
  List<view.WordView?> wordView = List.generate(50, (index) => null);
  Word({Key? key, required this.word}) : super(key: key);

  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  final TextEditingController _wordSearchController = TextEditingController();
  final _myFocusNode = FocusNode();

  String inputText = '';
  bool isLoading = true;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _loadSetting();
    //getWordData(widget.word).whenComplete(() => setState(() {}));
  }

  _loadSetting() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //_autoFocus = prefs.getBool('autoFocus') ?? true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _myFocusNode.dispose();
    _scrollController.dispose();
    _wordSearchController.dispose();
  }

  Future<void> getWordSearchData(String query) async {
    query = _textReplace(query);
    String wordJson = await WordSearch().getWords(query);
    //print('받아오고');
    setState(() {
      if (wordJson.isNotEmpty) {
        widget.wordModel = search.WordModel.fromJson(jsonDecode(wordJson));
      } else {
        setState(() {
          isLoading = false;
        });
        const snackBar = SnackBar(
          content: Text('검색 결과가 없습니다!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    setState(() {
      if (widget.wordModel.channel?.item?.first.targetCode != null) {
        RecentWordBoxes.getWords().put(
          widget.wordModel.channel?.item?.first.targetCode,
          RecentWord(
            widget.wordModel.channel?.item?.first.word ?? '',
            widget.wordModel.channel?.lastbuilddate ?? '',
            widget.wordModel.channel?.item?.first.targetCode ?? '',
          ),
        );
      }
    });

    var channel = widget.wordModel.channel;
    int totalnum = channel?.total ?? 0;
    int num = channel?.num ?? 0;
    if (totalnum >= num) {
      totalnum = num;
    }

    List total = totalnum == 1 ? [0] : List.generate(totalnum, (i) => i + 1);

    for (var num in total) {
      var index = num;
      final tmp = getWordViewData(query: query, num: index.toString());
      tmp.then((value) {
        totalnum == 1 ? widget.wordView[index] = value : widget.wordView[index - 1] = value;
      }); // async하게 변경, 인덱스대로 넣기
      setState(() {
        isLoading = false;
      });

      //view.WordView tmp = await getWordViewData(query, e.toString());
      //widget.wordView.add(tmp);
    }
    //isLoading = false; // null 반환 대비 아래로 이동
    //print('변경');
  }

  Future<void> getWordRandomViewData(String num) async {
    String wordJsonView = await WordRandomViewSearch().getWords(num);
    //print('받아오고');
    view.WordView wordViewData = view.WordView.fromJson(jsonDecode(wordJsonView));
    if (wordViewData.channel == null || wordViewData.channel?.total == 0) {
      var num2 = Random().nextInt(422879);
      await getWordRandomViewData(num2.toString());
    } else {
      String str = _textReplace(wordViewData.channel?.item?.wordInfo?.word ?? '');
      getWordSearchData(str);
      _wordSearchController.text = str;
    }
  }

  String _textReplace(String str) {
    str = str.replaceAll('-', '');
    str = str.replaceAll('^', '');
    str = str.replaceAll(' ', '');
    return str;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    _myFocusNode.addListener(() {
      setState(() {});
    });
    return Consumer<HiveService>(builder: (context, hiveService, child) {
      return Padding(
        padding: MediaQuery.of(context).viewPadding,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: _wordSearchController.text.isEmpty
              ? Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                          )),
                    ),
                    Positioned.fill(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.017),
                            child: CustomTextFiled(context),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await getWordRandomViewData(Random().nextInt(422879).toString());
                            isLoading = false;
                          },
                          child: Text(
                            '다너다너',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 30,
                                fontFamily: 'KoPubBatang',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                                letterSpacing: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.43,
                      width: MediaQuery.of(context).size.width,
                      //color: const Color(0xffa1df6e),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                              // bottomLeft: Radius.circular(30.0),
                              // bottomRight: Radius.circular(30.0),
                              )),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await getWordRandomViewData(Random().nextInt(422879).toString());
                            isLoading = false;
                          },
                          child: Text(
                            '다너다너',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 30,
                                fontFamily: 'KoPubBatang',
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                                letterSpacing: 10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child:
                                Align(alignment: Alignment.center, child: CustomTextFiled(context)),
                          ),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  padding: const EdgeInsets.only(left: 15),
                                  constraints: const BoxConstraints(),
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const RecentWordList()),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _wordSearchController.text = result;
                                      getWordSearchData(result);
                                    }
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    size: 18,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _wordSearchController.text.isNotEmpty
                                ? IconButton(
                                    padding: const EdgeInsets.only(right: 15),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      _wordSearchController.text = ' ';
                                      FocusScope.of(context).requestFocus(_myFocusNode);
                                    },
                                    splashColor: Colors.transparent,
                                    icon: const Icon(Icons.clear),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                    //const CustomDivider(),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: isLoading == true
                            ? Center(
                                child: Center(
                                  child: CupertinoActivityIndicator(
                                    animating: isLoading,
                                    radius: 20,
                                  ),
                                ),
                              )
                            : Scrollbar(
                                key: GlobalKey(debugLabel: 'search'),
                                controller: _scrollController,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    controller: _scrollController,
                                    itemCount: ((widget.wordModel.channel?.total ?? 0) >
                                            (widget.wordModel.channel?.num ?? 0))
                                        ? widget.wordModel.channel?.num ?? 0 + 1
                                        : widget.wordModel.channel?.total ?? 0 + 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      // if (index ==
                                      //     (widget.wordModel.channel?.total ??
                                      //             0) -
                                      //         1) {
                                      //   return const SizedBox(height: 70);
                                      // }
                                      if (index == widget.wordModel.channel?.total) {
                                        return const SizedBox(height: 50);
                                      } else {
                                        return Slidable(
                                          key: UniqueKey(),
                                          endActionPane: ActionPane(
                                            extentRatio: 1 / 6,
                                            motion: const ScrollMotion(),
                                            // dismissible: DismissiblePane(
                                            //   onDismissed: () {},
                                            // ),
                                            children: [
                                              SlidableAction(
                                                autoClose: true,
                                                flex: 1,
                                                onPressed: (context) {
                                                  Item item =
                                                      widget.wordModel.channel?.item?[index] ??
                                                          Item();
                                                  if (WordBoxes.getWords()
                                                      .containsKey(item.targetCode)) {
                                                    SnackBar snackBar = SnackBar(
                                                      content: Text('${item.word}는 이미 저장되었습니다.'),
                                                      duration: const Duration(seconds: 1),
                                                    );
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(snackBar);
                                                  } else {
                                                    hiveService.updateItem(
                                                        item.targetCode ?? '',
                                                        wordtest(
                                                            item.word ?? '',
                                                            int.parse(item.supNo ?? ''),
                                                            item.pos ?? '',
                                                            item.sense?.definition ?? '',
                                                            item.targetCode ?? '',
                                                            widget.wordModel.channel?.lastbuilddate,
                                                            null));
                                                    SnackBar snackBar = SnackBar(
                                                      content: Text('${item.word} 넣었습니다'),
                                                      duration: const Duration(seconds: 1),
                                                    );
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                },
                                                backgroundColor: Theme.of(context).primaryColor,
                                                foregroundColor: Theme.of(context).primaryColorDark,
                                                icon: FontAwesomeIcons.floppyDisk,
                                                padding: const EdgeInsets.all(0),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (widget.wordView[index] != null) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => WordViewInfo(
                                                            item: widget
                                                                .wordView[index]?.channel?.item)));
                                              } else {
                                                const snackBar = SnackBar(
                                                  content: Text(
                                                      '현재 국립국어원 Open API의 문제로\n 사진 자료가 있는 단어는 상세검색이 되지 않습니다.!'),
                                                  duration: Duration(seconds: 2),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            child: WordInfo(
                                              item: widget.wordModel.channel?.item?[index] ??
                                                  search.Item(),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                      ),
                    ), //const CustomDivider(),
                  ],
                ),
        ),
      );
    });
  }

  // ignore: non_constant_identifier_names
  TextField CustomTextFiled(BuildContext context) {
    return TextField(
      //selectionHeightStyle: BoxHeightStyle.includeLineSpacingBottom,
      controller: _wordSearchController,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      //textAlignVertical: TextAlignVertical.center,
      cursorColor: Theme.of(context).primaryColorDark,
      //cursorHeight: ,
      autofocus: false,
      focusNode: _myFocusNode,
      autocorrect: false,
      onSubmitted: (String text) {
        inputText = text;
        //print('입력하신 단어는 $inputText 입니다.');
        setState(() {
          isLoading = true;
          //widget.wordView.clear();
          getWordSearchData(inputText);
        });
      },
      //scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration.collapsed(
        fillColor: Colors.transparent,
        filled: true,
        hintText: _myFocusNode.hasFocus ? '' : '다너를 입력해 주세요',
        border: InputBorder.none,
      ),
      style: const TextStyle(
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        height: 1.5,
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.1,
      thickness: 0.5,
      color: Colors.grey,
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:word_word/providers/hive_service.dart';

import '../boxes.dart';
import '../models/word.dart';
import '../providers/hive_service.dart';
import '../screens/write_list.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> with TickerProviderStateMixin {
  late QuillController _quillController;
  final _scrollController = ScrollController();
  late final AnimationController _animationController;

  final focusNode = FocusNode();
  // ignore: prefer_typing_uninitialized_variables
  late var currentWord;

  //var words = WordBoxes.getWords().values.toList().cast();
  // ignore: prefer_typing_uninitialized_variables
  //late var currentWord;

  int currentIndex = 0;

  final double toolbarIconSize = 18;
  final double _fontSize = 15;

  @override
  void initState() {
    //currentWord = HiveService().getFirstItems();
    //.wordtest('', 1, '', '', '', null, null);
    _animationController = AnimationController(vsync: this);
    _quillController = QuillController.basic();
    currentWord = getCurrentWord();
    // if (currentWord.write != null) {
    //   _quillController = QuillController(
    //     document: Document.fromJson(jsonDecode(currentWord.write)),
    //     selection: const TextSelection.collapsed(offset: 0),
    //   );
    // } else {
    //   _quillController = QuillController.basic();
    // }
    super.initState();
  }

  @override
  void dispose() {
    _quillController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<wordtest>>(
      valueListenable: WordBoxes.getWords().listenable(),
      builder: (context, box, _) {
        var words = WordBoxes.getWords().values.toList().cast<wordtest>();
        words.sort((b, a) => (a.saveTime ?? '').compareTo(b.saveTime ?? ''));

        if (words.isNotEmpty && words[currentIndex].write != null) {
          _quillController = QuillController(
            document: Document.fromJson(jsonDecode(words[currentIndex].write!)),
            selection: const TextSelection.collapsed(offset: 0),
          );
        } else {
          _quillController = QuillController.basic();
        }
        //currentWord = words[0];
        return buildContext(words);
      },
    );
  }

  Widget buildContext(List<wordtest> words) {
    if (words.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _animationController
                  ..duration = const Duration(seconds: 4)
                  ..forward();
              },
              child: Lottie.asset(
                'assets/lottie/empty_box.json',
                repeat: true,
                height: 200,
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController.addListener(() {});
                  _animationController
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
            const Text(
              '텅텅 비었다!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      );
    } else {
      return Consumer<HiveService>(
        builder: (context, hiveService, child) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
              padding: MediaQuery.of(context).viewPadding,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    //color: const Color(0xffa1df6e),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Stack(children: [
                      Positioned(
                        height: MediaQuery.of(context).size.height * 0.06,
                        left: 5,
                        child: TextButton(
                            onPressed: () async {
                              int result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WriteList()),
                              );
                              setState(() {
                                currentIndex = words.length - result - 1;
                              });
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Text(
                              '목록',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            )),
                      ),
                      Center(
                        child: Text(
                          '다너다너',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                              fontFamily: 'KoPubBatang',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark,
                              letterSpacing: 4),
                        ),
                      ),
                      Positioned(
                        height: MediaQuery.of(context).size.height * 0.06,
                        right: 5,
                        child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              String json =
                                  jsonEncode(_quillController.document.toDelta().toJson());
                              words[currentIndex].write = json;
                              hiveService.updateItem(
                                  words[currentIndex].targetCode, words[currentIndex]);
                              SnackBar snackBar = const SnackBar(
                                content: Text('저장되었습니다'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Text(
                              '저장',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            )),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await showCupertinoModalPopup(
                                context: context,
                                builder: (context) => SizedBox(
                                      height: 200.0,
                                      child: CupertinoPicker(
                                        useMagnifier: true,
                                        magnification: 1.2,
                                        squeeze: 1.4,
                                        children: words
                                            .map((e) => Center(
                                                    child: Text(
                                                  e.word,
                                                  style: const TextStyle(fontFamily: 'KoPubBatang'),
                                                )))
                                            .toList(),
                                        itemExtent: 40.0,
                                        backgroundColor: Colors.white.withOpacity(1),
                                        scrollController:
                                            FixedExtentScrollController(initialItem: currentIndex),
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            if (!_quillController.document.isEmpty()) {
                                              String json = jsonEncode(// 자동 저장
                                                  _quillController.document.toDelta().toJson());
                                              words[currentIndex].write = json;
                                              hiveService.updateItem(words[currentIndex].targetCode,
                                                  words[currentIndex]);
                                            }

                                            currentIndex = index;
                                            //currentWord = words[currentIndex];
                                            if (words[currentIndex].write != null) {
                                              _quillController = QuillController(
                                                document: Document.fromJson(
                                                    jsonDecode(words[currentIndex].write ?? '')),
                                                selection: const TextSelection.collapsed(offset: 0),
                                              );
                                            } else {
                                              _quillController = QuillController.basic();
                                            }
                                          });
                                        },
                                      ),
                                    ));
                          },
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                words[currentIndex].word, //단어이름
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  //    letterSpacing: 4.0
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(words[currentIndex].pos),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: () async {
                              await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => SizedBox(
                                        height: 200.0,
                                        child: CupertinoPicker(
                                          squeeze: 1,
                                          children: words
                                              .map((e) => Center(child: Text(e.definition)))
                                              .toList(),
                                          itemExtent: 60.0,
                                          backgroundColor: Colors.white,
                                          scrollController: FixedExtentScrollController(
                                              initialItem: currentIndex),
                                          onSelectedItemChanged: (int index) {
                                            // setState(() {
                                            //   currentIndex = index;
                                            //   currentWord = words[currentIndex];
                                            //   if (currentWord.write != null) {
                                            //     _quillController = QuillController(
                                            //       document: Document.fromJson(
                                            //           jsonDecode(currentWord.write ?? '')),
                                            //       selection:
                                            //           const TextSelection.collapsed(offset: 0),
                                            //     );
                                            //   } else {
                                            //     _quillController = QuillController.basic();
                                            //   }
                                            // });
                                          },
                                        ),
                                      ));
                            },
                            child: Text(
                              words[currentIndex].definition,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //QuillToolbar.basic(controller: controller)
                  const Divider(
                    height: 10,
                    thickness: 0.5,
                    indent: 25,
                    endIndent: 25,
                  ),
                  Expanded(
                    flex: 10,
                    child: Scrollbar(
                      child: QuillEditor(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                        //minHeight: MediaQuery.of(context).size.height * 0.2,
                        expands: false,
                        focusNode: focusNode,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        scrollController: _scrollController,
                        scrollPhysics: const BouncingScrollPhysics(),
                        scrollable: true,
                        autoFocus: false,
                        locale: const Locale('ko'),
                        controller: _quillController,
                        readOnly: false,
                        //keyboardAppearance: Brightness.light,
                        showCursor: true,
                        floatingCursorDisabled: true,
                        //paintCursorAboveText: false,
                        placeholder: '다너에 대한 생각이나 경험을 적어주세요',
                        customStyles: DefaultStyles(
                          paragraph: DefaultTextBlockStyle(
                              TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'KoPubBatang',
                                color: Colors.black,
                              ),
                              const Tuple2(0.0, 4.0),
                              const Tuple2(0.0, 0.0),
                              null),
                          placeHolder: DefaultTextBlockStyle(
                              TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'KoPubBatang',
                                color: Colors.grey,
                              ),
                              const Tuple2(0.0, 4.0),
                              const Tuple2(0.0, 0.0),
                              null),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.085,
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.06)
                  if (focusNode.hasFocus)
                    CustomQuillToolbar(
                      toolbarIconSize: toolbarIconSize,
                      quillController: _quillController,
                      iconTheme: QuillIconTheme(
                        iconSelectedFillColor: Theme.of(context).primaryColor,
                        borderRadius: 10,
                      ),
                    ),
                ],
              )),
        ),
      );
    }
  }
}

class CustomQuillToolbar extends StatelessWidget {
  const CustomQuillToolbar({
    Key? key,
    required this.toolbarIconSize,
    required QuillController quillController,
    required this.iconTheme,
  })  : _quillController = quillController,
        super(key: key);

  final double toolbarIconSize;
  final QuillController _quillController;
  final QuillIconTheme iconTheme;

  @override
  Widget build(BuildContext context) {
    return QuillToolbar(
      toolbarHeight: kDefaultIconSize * 1,
      toolbarIconAlignment: WrapAlignment.spaceBetween,
      locale: const Locale('ko'),
      children: [
        IconButton(
          iconSize: 20,
          onPressed: () {
            Clipboard.setData(ClipboardData(
                text: _quillController.document.getPlainText(0, _quillController.document.length)));
          },
          icon: const Icon(Icons.copy),
        ),
        TextButton(
          onPressed: () {},
          child: Text((_quillController.document.length - 1).toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: HistoryButton(
            icon: Icons.undo_outlined,
            iconSize: toolbarIconSize,
            controller: _quillController,
            undo: true,
            iconTheme: iconTheme,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: HistoryButton(
            icon: Icons.redo_outlined,
            iconSize: toolbarIconSize,
            controller: _quillController,
            undo: false,
            iconTheme: iconTheme,
          ),
        ),
        // ToggleStyleButton(
        //   attribute: Attribute.bold,
        //   icon: Icons.format_bold,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   iconTheme: iconTheme,
        // ),
        // ToggleStyleButton(
        //   attribute: Attribute.italic,
        //   icon: Icons.format_italic,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   iconTheme: iconTheme,
        // ),
        // ToggleStyleButton(
        //   attribute: Attribute.underline,
        //   icon: Icons.format_underline,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   iconTheme: iconTheme,
        // ),
        // ToggleStyleButton(
        //   attribute: Attribute.strikeThrough,
        //   icon: Icons.format_strikethrough,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   iconTheme: iconTheme,
        // ),
        // ColorButton(
        //   icon: Icons.color_lens,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   background: false,
        //   iconTheme: iconTheme,
        // ),
        // ColorButton(
        //   icon: Icons.format_color_fill,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   background: true,
        //   iconTheme: iconTheme,
        // ),
        // ClearFormatButton(
        //   icon: Icons.format_clear,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   iconTheme: iconTheme,
        // // ),
        // SelectAlignmentButton(
        //   controller: _quillController,
        //   iconSize: toolbarIconSize,
        //   iconTheme: iconTheme,
        //   showLeftAlignment: true,
        //   showCenterAlignment: true,
        //   showRightAlignment: true,
        //   showJustifyAlignment: false,
        // ),
        // SelectHeaderStyleButton(
        //   controller: _quillController,
        //   iconSize: toolbarIconSize,
        //   iconTheme: iconTheme,
        // ),
        // IndentButton(
        //   icon: Icons.format_indent_increase,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   isIncrease: true,
        //   iconTheme: iconTheme,
        // ),
        // IndentButton(
        //   icon: Icons.format_indent_decrease,
        //   iconSize: toolbarIconSize,
        //   controller: _quillController,
        //   isIncrease: false,
        //   iconTheme: iconTheme,
        // ),
        // IconButton(
        //   onPressed: () {
        //     FocusScope.of(context).requestFocus(FocusNode());
        //   },
        //   icon: const Icon(
        //     FontAwesomeIcons.keyboard,
        //     size: 18,
        //     color: Colors.grey,
        //   ),
        //   padding: EdgeInsets.zero,
        // ),
      ],
    );
  }
}

wordtest getCurrentWord() {
  List<wordtest> words = WordBoxes.getWords().values.toList();
  words.sort((b, a) => (a.saveTime ?? '').compareTo(b.saveTime ?? ''));
  if (words.isNotEmpty) {
    return words[0];
  } else {
    HiveService().updateItem(
        '76404',
        wordtest(
            '단어',
            0,
            '명사',
            '분리하여 자립적으로 쓸 수 있는 말이나 이에 준하는 말. 또는 그 말의 뒤에 붙어서 문법적 기능을 나타내는 말. “철수가 영희의 일기를 읽은 것 같다.”에서 자립적으로 쓸 수 있는 ‘철수’, ‘영희’, ‘일기’, ‘읽은’, ‘같다’와 조사 ‘가’, ‘의’, ‘를’, 의존 명사 ‘것’ 따위이다.',
            '76404',
            '20220512183401',
            null));
    return wordtest(
        '단어',
        0,
        '명사',
        '분리하여 자립적으로 쓸 수 있는 말이나 이에 준하는 말. 또는 그 말의 뒤에 붙어서 문법적 기능을 나타내는 말. “철수가 영희의 일기를 읽은 것 같다.”에서 자립적으로 쓸 수 있는 ‘철수’, ‘영희’, ‘일기’, ‘읽은’, ‘같다’와 조사 ‘가’, ‘의’, ‘를’, 의존 명사 ‘것’ 따위이다.',
        '76404',
        '20220512183401',
        null);
  }
}

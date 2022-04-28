import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:tuple/tuple.dart';

import '../boxes.dart';
import '../models/word.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final _quillController = QuillController.basic();
  final _scrollController = ScrollController();
  final focusNode = FocusNode();

  var words = WordBoxes.getWords().values.toList().cast();
  // ignore: prefer_typing_uninitialized_variables
  late var currentWord;
  int currentIndex = 0;

  double toolbarIconSize = 18;
  final double _fontSize = 14;

  @override
  void initState() {
    words.sort((b, a) => a.saveTime.compareTo(b.saveTime));
    currentWord = words.first;
    super.initState();
  }

  @override
  void dispose() {
    _quillController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuillIconTheme iconTheme = QuillIconTheme(
      iconSelectedColor: Colors.black,
      iconUnselectedColor: Colors.grey,
      iconSelectedFillColor: Theme.of(context).primaryColor,
    );

    return GestureDetector(
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
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: () {},
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
                        var json = jsonEncode(_quillController.document.toDelta().toJson());
                        currentWord.write = json;
                        WordBoxes.getWords().putAt(currentIndex, currentWord);
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
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showCupertinoModalPopup(
                              context: context,
                              builder: (context) => SizedBox(
                                    height: 200.0,
                                    child: CupertinoPicker(
                                      squeeze: 1.5,
                                      children:
                                          words.map((e) => Center(child: Text(e.word))).toList(),
                                      itemExtent: 40.0,
                                      backgroundColor: Colors.white.withOpacity(1),
                                      scrollController: FixedExtentScrollController(initialItem: 0),
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          currentIndex = index;
                                          currentWord = words[index];
                                        });
                                      },
                                    ),
                                  ));
                        },
                        child: Text(
                          currentWord.word, //단어이름
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            //    letterSpacing: 4.0
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(currentWord.pos),
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
                                    squeeze: 1.5,
                                    children: words
                                        .map((e) => Center(child: Text(e.definition)))
                                        .toList(),
                                    itemExtent: 40.0,
                                    backgroundColor: Colors.white,
                                    scrollController: FixedExtentScrollController(initialItem: 0),
                                    onSelectedItemChanged: (int index) {
                                      setState(() {
                                        currentWord = words[index];
                                      });
                                    },
                                  ),
                                ));
                      },
                      child: Text(
                        currentWord.definition,
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
            // if (focusNode.hasFocus)
            //   CustomQuillToolbar(
            //       toolbarIconSize: toolbarIconSize,
            //       quillController: _quillController,
            //       iconTheme: iconTheme),
            Expanded(
              flex: 10,
              child: QuillEditor(
                //maxHeight: MediaQuery.of(context).size.height * 0.4,
                //minHeight: MediaQuery.of(context).size.height * 0.2,
                expands: false,
                focusNode: focusNode,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                scrollController: _scrollController,
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
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.085,
            //   color: Theme.of(context).primaryColor,
            // ),
            //SizedBox(height: MediaQuery.of(context).size.height * 0.06)
          ],
        ),
      ),
    );
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
      toolbarHeight: kDefaultIconSize * 2,
      locale: const Locale('ko'),
      children: [
        HistoryButton(
          icon: Icons.undo_outlined,
          iconSize: toolbarIconSize,
          controller: _quillController,
          undo: true,
          iconTheme: iconTheme,
        ),
        HistoryButton(
          icon: Icons.redo_outlined,
          iconSize: toolbarIconSize,
          controller: _quillController,
          undo: false,
          iconTheme: iconTheme,
        ),
        ToggleStyleButton(
          attribute: Attribute.bold,
          icon: Icons.format_bold,
          iconSize: toolbarIconSize,
          controller: _quillController,
          iconTheme: iconTheme,
        ),
        ToggleStyleButton(
          attribute: Attribute.italic,
          icon: Icons.format_italic,
          iconSize: toolbarIconSize,
          controller: _quillController,
          iconTheme: iconTheme,
        ),
        ToggleStyleButton(
          attribute: Attribute.underline,
          icon: Icons.format_underline,
          iconSize: toolbarIconSize,
          controller: _quillController,
          iconTheme: iconTheme,
        ),
        ToggleStyleButton(
          attribute: Attribute.strikeThrough,
          icon: Icons.format_strikethrough,
          iconSize: toolbarIconSize,
          controller: _quillController,
          iconTheme: iconTheme,
        ),
        ColorButton(
          icon: Icons.color_lens,
          iconSize: toolbarIconSize,
          controller: _quillController,
          background: false,
          iconTheme: iconTheme,
        ),
        ColorButton(
          icon: Icons.format_color_fill,
          iconSize: toolbarIconSize,
          controller: _quillController,
          background: true,
          iconTheme: iconTheme,
        ),
        ClearFormatButton(
          icon: Icons.format_clear,
          iconSize: toolbarIconSize,
          controller: _quillController,
          iconTheme: iconTheme,
        ),
        SelectAlignmentButton(
          controller: _quillController,
          iconSize: toolbarIconSize,
          iconTheme: iconTheme,
          showLeftAlignment: true,
          showCenterAlignment: true,
          showRightAlignment: true,
          showJustifyAlignment: false,
        ),
        SelectHeaderStyleButton(
          controller: _quillController,
          iconSize: toolbarIconSize,
          iconTheme: iconTheme,
        ),
        IndentButton(
          icon: Icons.format_indent_increase,
          iconSize: toolbarIconSize,
          controller: _quillController,
          isIncrease: true,
          iconTheme: iconTheme,
        ),
        IndentButton(
          icon: Icons.format_indent_decrease,
          iconSize: toolbarIconSize,
          controller: _quillController,
          isIncrease: false,
          iconTheme: iconTheme,
        ),
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

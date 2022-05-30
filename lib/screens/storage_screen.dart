import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:word_word/screens/word_info_screen.dart';
import 'package:word_word/widgets/word_chip.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:word_word/models/word.dart';
import 'package:word_word/boxes.dart';
import 'package:lottie/lottie.dart';

import '../models/word_view.dart';
import '../providers/hive_service.dart';
import '../providers/word_search.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> with TickerProviderStateMixin {
  int? groupValue = 0;
  final _valueList = ['최신순', '가나다순', '품사순'];
  var _dropdownValue = '최신순';

  late final AnimationController _controller;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveService>(
      builder: (context, hiveService, child) => Scaffold(
        body: ValueListenableBuilder<Box<wordtest>>(
          valueListenable: WordBoxes.getWords().listenable(),
          builder: (context, box, _) {
            var words = box.values.toList().cast<wordtest>();
            switch (_dropdownValue) {
              case '가나다순':
                words.sort((a, b) => a.word.compareTo(b.word)); // ㄱㄴㄷ
                break;
              case '최신순':
                words.sort((b, a) => (a.saveTime ?? '').compareTo(b.saveTime ?? ''));
                break; // 추가한 순
              case '품사순':
                words.sort((a, b) => a.pos.compareTo(b.pos)); // 품사
                break;
            }

            return buildContext(words);
          },
        ),
      ),
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
                _controller
                  ..duration = const Duration(seconds: 4)
                  ..forward();
              },
              child: Lottie.asset(
                'assets/lottie/empty_box.json',
                repeat: true,
                height: 200,
                controller: _controller,
                onLoaded: (composition) {
                  _controller.addListener(() {});
                  _controller
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
      return Padding(
        padding: MediaQuery.of(context).viewPadding,
        child: Column(
          children: [
            // const SizedBox(height: 10),
            // const Text(
            //   '다너다너',
            //   style: TextStyle(
            //     //fontWeight: FontWeight.bold,
            //     fontSize: 30,
            //   ),
            // ),
            // const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              //color: const Color(0xffa1df6e),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
              child: Center(
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
            ),
            const SizedBox(height: 5),
            Align(
              //alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: '총 ',
                    style: const TextStyle(
                      color: Colors.black,
                      //fontFamily: 'KoPubBatang',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${words.length}개',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            //fontWeight: FontWeight.bold,
                          )),
                      const TextSpan(text: '의 단어', style: TextStyle(color: Colors.black)),
                    ]),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _dropdownValue,
                    onChanged: dropdownCallback,
                    elevation: 0,
                    underline: const Text(''),
                    focusColor: Colors.green,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black87, fontFamily: 'KoPubBatang'),
                  ),
                  // Center(
                  //   child: CupertinoSlidingSegmentedControl(
                  //     padding: const EdgeInsets.all(4),
                  //     groupValue: groupValue,
                  //     children: const {
                  //       0: Icon(FontAwesomeIcons.listUl),
                  //       1: Icon(FontAwesomeIcons.minus),
                  //     },
                  //     onValueChanged: (groupValue) {
                  //       setState(() {
                  //         this.groupValue = groupValue as int?;
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Consumer<HiveService>(
              builder: (context, hiveService, child) => Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                      scrollDirection: groupValue == 0 ? Axis.vertical : Axis.vertical,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      itemCount: WordBoxes.getWords().length,
                      itemBuilder: (context, int index) {
                        var word = words[index];
                        return groupValue == 0
                            ? Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                child: Slidable(
                                  key: UniqueKey(),
                                  endActionPane: ActionPane(
                                    dragDismissible: false,
                                    extentRatio: 1 / 5,
                                    motion: const DrawerMotion(),
                                    children: [
                                      // SlidableAction(
                                      //   autoClose: true,
                                      //   flex: 1,
                                      //   onPressed: (context) {},
                                      //   //backgroundColor: Theme.of(context).primaryColor,
                                      //   foregroundColor: Theme.of(context).primaryColorDark,
                                      //   icon: FontAwesomeIcons.pen,
                                      //   // spacing: 10,
                                      //   // label: '적기',
                                      // ),
                                      SlidableAction(
                                        autoClose: true,
                                        flex: 1,
                                        onPressed: (context) {
                                          hiveService.deleteItem(word);
                                        },
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(0xfffe6f6e),
                                        icon: FontAwesomeIcons.trash,
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                        borderRadius: BorderRadius.circular(10),
                                        // spacing: 10,
                                        // label: '빼기',
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                      onTap: () async {
                                        WordView wordView = await getWordViewData(
                                            targetCode: words[index].targetCode);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WordViewInfo(item: wordView.channel?.item)));
                                      },
                                      child: buildListCard(context, word)),
                                ),
                              )
                            : WordChip(word: word.word);
                      }),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildListCard(BuildContext context, wordtest word) {
    return Card(
      elevation: 0.7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //sticky header 적용하기, 날짜, ㄱㄴㄷ, 품
            Stack(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word.word,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (word.supNo == 0)
                    const SizedBox(width: 1)
                  else
                    Text(
                      word.supNo.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              if (word.saveTime != null)
                Positioned(
                  right: 0,
                  top: 3,
                  child: Text(
                    DateFormat('yy/MM/dd')
                        .format(DateTime.parse(word.saveTime!.substring(0, 8)))
                        .toString(),
                    style: TextStyle(color: Colors.grey.shade300, fontSize: 10),
                  ),
                )
            ]),

            const SizedBox(height: 5),
            RichText(
                text: TextSpan(
                  text: word.pos,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'KoPubBatang',
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${word.definition}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.fade),
          ],
        ),
      ),
    );
  }
}

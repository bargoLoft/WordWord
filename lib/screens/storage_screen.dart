import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:WordWord/models/word.dart';
import 'package:WordWord/boxes.dart';

//import 'package:WordWord/widgets/word_chip.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<wordtest>>(
        valueListenable: Boxes.getWords().listenable(),
        builder: (context, box, _) {
          final words = box.values.toList().cast<wordtest>();
          return buildContext(words);
        },
      ),
    );
  }

  Widget buildContext(List<wordtest> words) {
    if (words.isEmpty) {
      return Center(
        child: Text(
          '텅텅 비었다!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            '다너다너',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 10),
          Align(
              //alignment: Alignment.centerLeft,
              child: Text('총 ${words.length}개의 단어')),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: Boxes.getWords().length,
              itemBuilder: (BuildContext context, int index) {
                var word = words[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        Boxes.getWords().delete(word.targetCode);
                        //Boxes.getWords().deleteFromDisk();
                      });
                    }
                  },
                  child: buildTransaction(context, word),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(BuildContext context, wordtest word) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.word,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (word.supNo == 0)
                  SizedBox(width: 1)
                else
                  Text(
                    word.supNo.toString(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 3),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '${word.pos}',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                word.definition,
                style: TextStyle(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteWord(wordtest word) {
    final box = Boxes.getWords();
    word.delete();
  }
}

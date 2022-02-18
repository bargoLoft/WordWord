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
      body: ValueListenableBuilder<Box<Word>>(
        valueListenable: Boxes.getWords().listenable(),
        builder: (context, box, _) {
          final words = box.values.toList().cast<Word>();
          return buildContext(words);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //deleteTransaction();
          //addWord('사과', 2, '명사', '아삭아삭한 사과');
        },
      ),
    );
  }

  Widget buildContext(List<Word> words) {
    if (words.isEmpty) {
      return const Center(
        child: Text(
          'No word yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Text('단어의 수는 총 ?'),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: words.length,
              itemBuilder: (BuildContext context, int index) {
                final word = words[index];
                return buildTransaction(context, word);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(BuildContext context, Word word) {
    return Card(
      child: ExpansionTile(
        title: Text(
          word.word,
        ),
        subtitle: Text(word.supNo.toString()),
        trailing: Text(word.definition),
      ),
    );
  }

  Future addWord(String name, int supNo, String pos, String definition) async {
    final word = Word(name, supNo, pos, definition);
    final box = Boxes.getWords();
    box.add(word);
  }

  void deleteWord(Word word) {
    final box = Boxes.getWords();
    word.delete();
  }
}

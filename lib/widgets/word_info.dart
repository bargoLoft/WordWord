import 'package:flutter/material.dart';
import 'package:WordWord/models/word_model.dart';

class WordInfo extends StatelessWidget {
  Item item;
  WordInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(20, 0, 15, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.word ?? '',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item.supNo ?? '0',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          child: Text(
            item.pos ?? '',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            item.sense?.definition ?? '',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:WordWord/models/word_model.dart';
import 'package:WordWord/main.dart';
import 'package:WordWord/screens/storage_screen.dart';
import 'package:WordWord/models/word.dart';

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
          padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
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
                item.supNo ?? '',
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
              //fontWeight: FontWeight.bold,
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

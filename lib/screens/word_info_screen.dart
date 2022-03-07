import 'package:WordWord/models/word_view.dart';
import 'package:flutter/material.dart';

class WordView extends StatefulWidget {
  final Item? item;
  const WordView({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
            Text(
                '${widget.item?.wordInfo?.pronunciationInfo?[0]}${widget.item?.targetCode}'),
          ],
        ),
      ),
    );
  }
}

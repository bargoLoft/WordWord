import 'package:flutter/material.dart';
import 'package:WordWord/screens/storage_screen.dart';

class WordChip extends StatefulWidget {
  String? word;

  WordChip({
    Key? key,
    required this.word,
  }) : super(key: key);

  @override
  State<WordChip> createState() => _WordChipState();
}

class _WordChipState extends State<WordChip> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
// avatar: Image.,
      label: Text('${widget.word}'),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      selected: _isSelected,
      onSelected: (newBoolValue) {
        setState(() {
          _isSelected = newBoolValue;
        });
      },
    );
  }
}

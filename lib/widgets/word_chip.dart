import 'package:flutter/material.dart';

class WordChip extends StatefulWidget {
  final String? word;

  const WordChip({
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ChoiceChip(
        elevation: 5,
        selectedColor: Colors.white,
        backgroundColor: Colors.grey.shade300,
// avatar: Image.,
        label: Text('${widget.word}'),
        labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        selected: _isSelected,
        onSelected: (newBoolValue) {
          setState(() {
            _isSelected = newBoolValue;
          });
        },
      ),
    );
  }
}

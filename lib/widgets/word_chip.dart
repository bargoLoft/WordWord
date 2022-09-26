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
    return ChoiceChip(
      padding: const EdgeInsets.symmetric(vertical: 0),
      elevation: 0.5,
      selectedColor: Colors.white,
      backgroundColor: Colors.white,
      shape: const StadiumBorder(side: BorderSide()),
      side: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
      label: Text('${widget.word}'),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelStyle: const TextStyle(
        fontSize: 13,
      ),
      selected: _isSelected,
      onSelected: (newBoolValue) {
        setState(() {
          _isSelected = newBoolValue;
        });
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

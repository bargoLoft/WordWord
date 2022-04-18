import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final _controller = QuillController.basic();
  final _scrollController = ScrollController();
  double toolbarIconSize = 18;

  @override
  Widget build(BuildContext context) {
    QuillIconTheme iconTheme = QuillIconTheme(
      iconSelectedColor: Colors.black,
      iconUnselectedColor: Colors.grey,
      iconSelectedFillColor: Theme.of(context).primaryColor,
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: QuillEditor(
              expands: false,
              focusNode: FocusNode(),
              padding: const EdgeInsets.all(10),
              scrollController: _scrollController,
              scrollable: true,
              autoFocus: false,
              locale: const Locale('ko'),
              controller: _controller,
              readOnly: false,
            ),
          ),
          QuillToolbar(
            toolbarHeight: kDefaultIconSize * 2,
            locale: const Locale('ko'),
            children: [
              HistoryButton(
                icon: Icons.undo_outlined,
                iconSize: toolbarIconSize,
                controller: _controller,
                undo: true,
                iconTheme: iconTheme,
              ),
              HistoryButton(
                icon: Icons.redo_outlined,
                iconSize: toolbarIconSize,
                controller: _controller,
                undo: false,
                iconTheme: iconTheme,
              ),
              ToggleStyleButton(
                attribute: Attribute.bold,
                icon: Icons.format_bold,
                iconSize: toolbarIconSize,
                controller: _controller,
                iconTheme: iconTheme,
              ),
              ToggleStyleButton(
                attribute: Attribute.italic,
                icon: Icons.format_italic,
                iconSize: toolbarIconSize,
                controller: _controller,
                iconTheme: iconTheme,
              ),
              ToggleStyleButton(
                attribute: Attribute.underline,
                icon: Icons.format_underline,
                iconSize: toolbarIconSize,
                controller: _controller,
                iconTheme: iconTheme,
              ),
              ToggleStyleButton(
                attribute: Attribute.strikeThrough,
                icon: Icons.format_strikethrough,
                iconSize: toolbarIconSize,
                controller: _controller,
                iconTheme: iconTheme,
              ),
              ColorButton(
                icon: Icons.color_lens,
                iconSize: toolbarIconSize,
                controller: _controller,
                background: false,
                iconTheme: iconTheme,
              ),
              ColorButton(
                icon: Icons.format_color_fill,
                iconSize: toolbarIconSize,
                controller: _controller,
                background: true,
                iconTheme: iconTheme,
              ),
              ClearFormatButton(
                icon: Icons.format_clear,
                iconSize: toolbarIconSize,
                controller: _controller,
                iconTheme: iconTheme,
              ),
              SelectAlignmentButton(
                controller: _controller,
                iconSize: toolbarIconSize,
                iconTheme: iconTheme,
                showLeftAlignment: true,
                showCenterAlignment: true,
                showRightAlignment: true,
                showJustifyAlignment: true,
              ),
              SelectHeaderStyleButton(
                controller: _controller,
                iconSize: toolbarIconSize,
                iconTheme: iconTheme,
              ),
              IndentButton(
                icon: Icons.format_indent_increase,
                iconSize: toolbarIconSize,
                controller: _controller,
                isIncrease: true,
                iconTheme: iconTheme,
              ),
              IndentButton(
                icon: Icons.format_indent_decrease,
                iconSize: toolbarIconSize,
                controller: _controller,
                isIncrease: false,
                iconTheme: iconTheme,
              ),
            ],
          ),
          //SizedBox(height: MediaQuery.of(context).size.height * 0.06)
        ],
      ),
    );
  }
}

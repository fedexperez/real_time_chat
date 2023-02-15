import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  const TextBox({super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                //Recibe el post, en nuestro caso deberia de ser
                //un evento que recibe el event.text
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    if (text.trim().isNotEmpty) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                  onPressed: (_isWriting
                      ? () {
                          return _handleSubmit(_textController.text.trim());
                        }
                      : null),
                  icon: const Icon(Icons.send)),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String text) {
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });
  }
}

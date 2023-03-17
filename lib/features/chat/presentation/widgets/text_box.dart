import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/message/message_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/widgets/bubble_message.dart';

class TextBox extends StatefulWidget {
  const TextBox({super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> with TickerProviderStateMixin {
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
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoadingState) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconButton(
                        onPressed: (_isWriting
                            ? () {
                                context
                                    .read<MessageBloc>()
                                    .add(MessageSendEvent(
                                      message: Message(
                                        text: _textController.text,
                                        fromUser: state.submitterUser.uid,
                                        toUser: state.receptorUser.uid,
                                      ),
                                    ));
                                return _handleSubmit(
                                  _textController.text.trim(),
                                );
                              }
                            : null),
                        icon: const Icon(Icons.send)),
                  );
                }
                if (state is ChatLoadedState) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconButton(
                        onPressed: (_isWriting
                            ? () {
                                context
                                    .read<MessageBloc>()
                                    .add(MessageSendEvent(
                                      message: Message(
                                        text: _textController.text,
                                        fromUser: state.submitterUser.uid,
                                        toUser: state.receptorUser.uid,
                                      ),
                                    ));
                                return _handleSubmit(
                                  _textController.text.trim(),
                                );
                              }
                            : null),
                        icon: const Icon(Icons.send)),
                  );
                }
                if (state is ChatErrorState) {
                  return Text(state.errorMessage);
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String text) {
    // final newMessage = BubbleMessage(
    //   message: Message(text: text, fromUser: '123', toUser: '1234'),
    //   animationController:
    //       AnimationController(vsync: this, duration: Duration(seconds: 1)),
    // );

    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });
  }
}

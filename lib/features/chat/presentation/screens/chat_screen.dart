import 'package:flutter/material.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/presentation/widgets/bubble_message.dart';

import 'package:real_time_chat/features/chat/presentation/widgets/text_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Message> messages = [
      Message(text: 'Hola Fer', userId: '123'),
      Message(text: 'Hola', userId: '1234'),
      Message(text: 'Como vas', userId: '1234'),
      Message(text: 'Bien y tu', userId: '123'),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: const [
            CircleAvatar(
              child: Text('LE'),
            ),
            Text(
              'Contact name',
              textScaleFactor: 0.6,
              maxLines: 1,
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  Message message = messages[index];
                  return BubbleMessage(
                    message: message,
                    animationController: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 200),
                    ),
                  );
                },
                itemCount: messages.length,
              ),
            ),
            const Divider(height: 1),
            Container(
              child: TextBox(),
            )
          ],
        ),
      ),
    );
  }
}

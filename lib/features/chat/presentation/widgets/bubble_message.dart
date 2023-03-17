import 'package:flutter/material.dart';

import 'package:real_time_chat/features/chat/domain/entities/message.dart';

class BubbleMessage extends StatelessWidget {
  final Message message;
  final String userId;
  final AnimationController animationController;

  const BubbleMessage({
    super.key,
    required this.message,
    required this.animationController,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: message.fromUser == userId
          ? _MyMessage(message: message.text)
          : _NotMyMessage(message: message.text),
    );
  }
}

class _MyMessage extends StatelessWidget {
  final String message;

  const _MyMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _NotMyMessage extends StatelessWidget {
  final String message;

  const _NotMyMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 5, right: 50, left: 5),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}

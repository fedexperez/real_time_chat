import 'dart:convert';

import 'package:real_time_chat/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required String text,
    required String fromUser,
    required String toUser,
  }) : super(
          text: text,
          fromUser: fromUser,
          toUser: toUser,
        );

  factory MessageModel.fromJson(String str) =>
      MessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        text: json["text"],
        fromUser: json["fromUser"],
        toUser: json["toUser"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "fromUser": fromUser,
        "toUser": toUser,
      };
}

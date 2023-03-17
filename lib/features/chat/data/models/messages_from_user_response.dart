import 'dart:convert';

import 'package:real_time_chat/features/chat/data/models/message_model.dart';
import 'package:real_time_chat/features/chat/domain/entities/messages_from_user_response.dart';

class MessagesFromUserResponseModel extends MessagesFromUserResponse {
  const MessagesFromUserResponseModel({
    required bool ok,
    required List<MessageModel> messages,
  }) : super(ok: ok, messages: messages);

  factory MessagesFromUserResponseModel.fromJson(String str) =>
      MessagesFromUserResponseModel.fromMap(json.decode(str));

  factory MessagesFromUserResponseModel.fromMap(Map<String, dynamic> json) =>
      MessagesFromUserResponseModel(
        ok: json["ok"],
        messages: List<MessageModel>.from(
            json["messages"].map((x) => MessageModel.fromMap(x))),
      );
}

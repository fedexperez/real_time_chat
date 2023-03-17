import 'dart:convert';

import 'package:real_time_chat/features/authentication/data/models/user_model.dart';
import 'package:real_time_chat/features/chat/domain/entities/users_response.dart';

class UsersResponseModel extends UsersResponse {
  const UsersResponseModel({
    required bool ok,
    required List<UserModel> users,
    required int startFrom,
  }) : super(ok: ok, users: users, startFrom: startFrom);

  factory UsersResponseModel.fromJson(String str) =>
      UsersResponseModel.fromMap(json.decode(str));

  factory UsersResponseModel.fromMap(Map<String, dynamic> json) =>
      UsersResponseModel(
        ok: json["ok"],
        users: List<UserModel>.from(
          json["users"].map((x) => UserModel.fromMap(x)),
        ),
        startFrom: json["startFrom"],
      );
}

import 'dart:convert';

import 'package:real_time_chat/features/authentication/data/models/user_model.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';

class AuthenticationResponseModel extends AuthenticationResponse {
  const AuthenticationResponseModel({
    required bool ok,
    required UserModel user,
    required String token,
  }) : super(
          ok: ok,
          user: user,
          token: token,
        );

  factory AuthenticationResponseModel.fromJson(String str) =>
      AuthenticationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthenticationResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthenticationResponseModel(
        ok: json["ok"],
        user: UserModel.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "user": UserModel,
        "token": token,
      };
}

import 'dart:convert';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String name,
    required String email,
    required bool online,
    required String uid,
  }) : super(
          name: name,
          email: email,
          online: online,
          uid: uid,
        );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "online": online,
        "uid": uid,
      };
}

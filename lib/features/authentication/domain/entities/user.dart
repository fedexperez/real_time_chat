import 'package:equatable/equatable.dart';

class User extends Equatable {
  final bool online;
  final String name;
  final String email;
  final String uid;

  const User({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
  });

  @override
  List<Object?> get props => [
        online,
        name,
        email,
        uid,
      ];
}

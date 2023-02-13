import 'package:equatable/equatable.dart';

class User extends Equatable {
  final bool online;
  final String email;
  final String name;
  final String id;

  const User({
    required this.online,
    required this.email,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        online,
        email,
        name,
        id,
      ];
}

import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String text;
  final String fromUser;
  final String toUser;

  const Message({
    required this.text,
    required this.fromUser,
    required this.toUser,
  });

  @override
  List<Object?> get props => [
        text,
        fromUser,
        toUser,
      ];
}

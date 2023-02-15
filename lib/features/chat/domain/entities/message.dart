import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String text;
  final String userId;

  const Message({
    required this.text,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        text,
        userId,
      ];
}

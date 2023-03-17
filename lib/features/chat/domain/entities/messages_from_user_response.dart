import 'package:equatable/equatable.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';

class MessagesFromUserResponse extends Equatable {
  final bool ok;
  final List<Message> messages;

  const MessagesFromUserResponse({
    required this.ok,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        ok,
        messages,
      ];
}

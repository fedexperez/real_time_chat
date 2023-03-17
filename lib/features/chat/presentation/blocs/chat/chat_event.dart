part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatLoadEvent extends ChatEvent {
  final User receptorUser;
  final User submitterUser;

  const ChatLoadEvent({
    required this.receptorUser,
    required this.submitterUser,
  });

  @override
  List<Object> get props => [receptorUser, submitterUser];
}

class ChatReceivedEvent extends ChatEvent {
  final void whenReceived;

  const ChatReceivedEvent({
    required this.whenReceived,
  });

  @override
  List<Object> get props => [];
}

class ChatReceivedMessageEvent extends ChatEvent {
  final User receptorUser;
  final User submitterUser;
  final List<Message> messages;

  const ChatReceivedMessageEvent({
    required this.receptorUser,
    required this.submitterUser,
    required this.messages,
  });

  @override
  List<Object> get props => [receptorUser, submitterUser, messages];
}

part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageSendEvent extends MessageEvent {
  final Message message;

  const MessageSendEvent({required this.message});

  @override
  List<Object> get props => [message];
}

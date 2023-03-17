part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitialState extends MessageState {}

class MessageSendingState extends MessageState {}

class MessageSentState extends MessageState {}

class MessageReceivedState extends MessageState {}

class MessageErrorState extends MessageState {
  final String errorMessage;

  const MessageErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

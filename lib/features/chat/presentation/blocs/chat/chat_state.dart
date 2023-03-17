part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {
  final User receptorUser;
  final User submitterUser;

  const ChatLoadingState({
    required this.receptorUser,
    required this.submitterUser,
  });

  @override
  List<Object> get props => [receptorUser, submitterUser];
}

class ChatLoadedState extends ChatState {
  final User receptorUser;
  final User submitterUser;
  final List<Message> messages;

  const ChatLoadedState({
    required this.receptorUser,
    required this.submitterUser,
    required this.messages,
  });

  @override
  List<Object> get props => [receptorUser, submitterUser, messages];
}

class ChatErrorState extends ChatState {
  final String errorMessage;

  const ChatErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

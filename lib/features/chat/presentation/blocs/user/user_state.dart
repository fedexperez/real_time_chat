part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final ServerStatus serverStatus;

  const UserLoadedState({required this.serverStatus});

  @override
  List<Object> get props => [serverStatus];
}

class UserDisconnectedState extends UserState {
  final ServerStatus serverStatus;

  const UserDisconnectedState({required this.serverStatus});

  @override
  List<Object> get props => [serverStatus];
}

class UserErrorState extends UserState {
  final String errorMessage;

  const UserErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

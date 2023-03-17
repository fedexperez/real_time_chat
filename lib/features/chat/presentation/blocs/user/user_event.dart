part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserConnectionEvent extends UserEvent {
  const UserConnectionEvent();

  @override
  List<Object> get props => [];
}

class UserDisconnectionEvent extends UserEvent {
  const UserDisconnectionEvent();

  @override
  List<Object> get props => [];
}

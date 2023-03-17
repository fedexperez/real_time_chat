part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersGetEvent extends UsersEvent {
  final int startFrom;

  const UsersGetEvent({this.startFrom = 0});

  @override
  List<Object> get props => [];
}

part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  final UsersResponse usersResponse;

  const UsersLoadedState({required this.usersResponse});

  @override
  List<Object> get props => [usersResponse];
}

class UsersErrorState extends UsersState {
  final String errorMessage;

  const UsersErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

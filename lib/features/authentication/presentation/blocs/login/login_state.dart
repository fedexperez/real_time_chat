part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final User user;

  const LoginLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginErrorState extends LoginState {
  final String errorMessage;

  const LoginErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

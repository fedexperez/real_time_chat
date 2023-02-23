part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final User user;

  const RegisterLoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterErrorState extends RegisterState {
  final String errorMessage;

  const RegisterErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

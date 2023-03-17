import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/check_logged_user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final CheckLoggedUser checkLoggedUser;

  LoginBloc({required this.loginUser, required this.checkLoggedUser})
      : super(LoginInitialState()) {
    on<LogUserEvent>((event, emit) async {
      emit(LoginLoadingState());
      final failureOrLogin =
          await loginUser(Params(email: event.email, password: event.password));
      failureOrLogin.fold((failure) {
        if (failure is ConnectionFailure) {
          emit(const LoginErrorState(
            errorMessage: Constants.connectionFailureMessage,
          ));
        } else {
          emit(const LoginErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (authentication) {
        emit(LoginLoadedState(user: authentication.user));
      });
    });

    on<LoginTokenCheckEvent>((event, emit) async {
      emit(LoginLoadingState());
      final failureOrLogin = await checkLoggedUser(NoParams());
      failureOrLogin.fold((failure) {
        if (failure is TokenFailure) {
          emit(LoginInitialState());
        } else if (failure is ConnectionFailure) {
          emit(const LoginErrorState(
            errorMessage: Constants.connectionFailureMessage,
          ));
        } else {
          emit(const LoginErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (authentication) {
        emit(LoginLoadedState(user: authentication.user));
      });
    });

    on<LogoutUserEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }
}

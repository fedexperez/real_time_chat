import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/register_user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      final failureOrRegister = await registerUser(Params(
        name: event.name,
        email: event.email,
        password: event.password,
      ));
      failureOrRegister.fold((failure) {
        if (failure is ConnectionFailure) {
          emit(const RegisterErrorState(
            errorMessage: Constants.connectionFailureMessage,
          ));
        } else {
          emit(const RegisterErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (authentication) {
        emit(RegisterLoadedState(user: authentication.user));
      });
    });
  }
}

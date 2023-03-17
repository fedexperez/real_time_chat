import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/features/chat/domain/entities/users_response.dart';
import 'package:real_time_chat/features/chat/domain/usecases/get_users.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc({required this.getUsers}) : super(UsersInitialState()) {
    on<UsersGetEvent>((event, emit) async {
      emit(UsersLoadingState());
      final failureOrUsersResponse =
          await getUsers(Params(startFrom: event.startFrom));
      failureOrUsersResponse.fold((failure) {
        if (failure is ConnectionFailure) {
          emit(const UsersErrorState(
            errorMessage: Constants.connectionFailureMessage,
          ));
        } else {
          emit(const UsersErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (usersResponse) {
        emit(UsersLoadedState(usersResponse: usersResponse));
      });
    });
  }
}

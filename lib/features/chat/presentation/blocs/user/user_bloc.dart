import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/chat/domain/entities/server_status.dart';
import 'package:real_time_chat/features/chat/domain/usecases/chat_user_connection.dart';
import 'package:real_time_chat/features/chat/domain/usecases/chat_user_disconnection.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ChatUserConnection chatUserConnection;
  final ChatUserDisconnection chatUserDisconnection;

  UserBloc(
      {required this.chatUserConnection, required this.chatUserDisconnection})
      : super(UserInitialState()) {
    on<UserConnectionEvent>((event, emit) async {
      emit(UserLoadingState());
      final failureOrSocketStatus = await chatUserConnection(NoParams());
      failureOrSocketStatus.fold((failure) {
        if (failure is SocketFailure) {
          emit(const UserErrorState(
            errorMessage: Constants.socketFailureMessage,
          ));
        } else {
          emit(const UserErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (socketStatus) {
        emit(UserLoadedState(serverStatus: socketStatus));
      });
    });

    on<UserDisconnectionEvent>((event, emit) async {
      emit(UserLoadingState());
      final failureOrSocketStatus = await chatUserDisconnection(NoParams());
      failureOrSocketStatus.fold((failure) {
        if (failure is SocketFailure) {
          emit(const UserErrorState(
            errorMessage: Constants.socketFailureMessage,
          ));
        } else {
          emit(const UserErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (socketStatus) {
        emit(UserDisconnectedState(serverStatus: socketStatus));
      });
    });
  }
}

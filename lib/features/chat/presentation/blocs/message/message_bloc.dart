import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/usecases/send_message.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final SendMessage sendMessage;

  MessageBloc({required this.sendMessage}) : super(MessageInitialState()) {
    on<MessageSendEvent>((event, emit) async {
      emit(MessageSendingState());
      final failureOrMessage =
          await sendMessage(Params(message: event.message));
      failureOrMessage.fold((failure) {
        if (failure is ConnectionFailure) {
          emit(const MessageErrorState(
            errorMessage: '',
          ));
        } else {
          emit(const MessageErrorState(
            errorMessage: '',
          ));
        }
      }, (messageSent) {
        emit(MessageSentState());
      });
    });
  }
}

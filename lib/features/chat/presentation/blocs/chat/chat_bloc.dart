import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/usecases/get_messages.dart';
import 'package:real_time_chat/features/chat/domain/usecases/receive_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ReceiveMessage receiveMessage;
  final GetMessages getMessages;

  ChatBloc({required this.receiveMessage, required this.getMessages})
      : super(ChatInitialState()) {
    on<ChatLoadEvent>((event, emit) async {
      emit(ChatLoadingState(
        submitterUser: event.submitterUser,
        receptorUser: event.receptorUser,
      ));
      final failureOrMessages =
          await getMessages(Params(fromUser: event.receptorUser.uid));
      failureOrMessages.fold((failure) {
        if (failure is SocketFailure) {
          emit(const ChatErrorState(
            errorMessage: '',
          ));
        }
      }, (messages) {
        emit(ChatLoadedState(
          submitterUser: event.submitterUser,
          receptorUser: event.receptorUser,
          messages: messages,
        ));
      });
    });

    on<ChatReceivedEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChatReceivedMessageEvent>((event, emit) async {
      emit(ChatLoadingState(
        receptorUser: event.receptorUser,
        submitterUser: event.submitterUser,
      ));
      final failureOrMessage = await receiveMessage(NoParams());
      failureOrMessage.fold((failure) {
        if (failure is SocketFailure) {
          emit(const ChatErrorState(
            errorMessage: '',
          ));
        }
      }, (message) {
        print('se supone que se agrego el mensaje');
        List<Message> messages = event.messages;
        messages.add(message);
        emit(ChatLoadedState(
          messages: messages,
          receptorUser: event.receptorUser,
          submitterUser: event.submitterUser,
        ));
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/widgets/bubble_message.dart';
import 'package:real_time_chat/features/chat/presentation/widgets/text_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //TODO: Recibir los mensajes Y recibir el usuario, construir dependiendo del estado en que se encuentre

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatInitialState) {}
            if (state is ChatLoadingState) {
              return Column(
                children: [
                  CircleAvatar(
                    child: Text(state.receptorUser.name.substring(0, 2)),
                  ),
                  Text(
                    state.receptorUser.name,
                    textScaleFactor: 0.6,
                    maxLines: 1,
                  ),
                ],
              );
            }
            if (state is ChatLoadedState) {
              return Column(
                children: [
                  CircleAvatar(
                    child: Text(state.receptorUser.name.substring(0, 2)),
                  ),
                  Text(
                    state.receptorUser.name,
                    textScaleFactor: 0.6,
                    maxLines: 1,
                  ),
                ],
              );
            }
            if (state is ChatErrorState) {}
            return Container();
          },
        ),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listenWhen: (previous, current) {
          bool f = previous is ChatLoadedState && current is ChatLoadingState;
          print(f);
          return f;
        },
        listener: (context, state) {
          if (state is ChatLoadedState) {
            context.read<ChatBloc>().add(ChatReceivedMessageEvent(
                  receptorUser: state.receptorUser,
                  submitterUser: state.submitterUser,
                  messages: state.messages,
                ));
          }
        },
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatInitialState) {}
            if (state is ChatLoadingState) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return null;
                      },
                      itemCount: 2,
                    ),
                  ),
                  const Divider(height: 1),
                  BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      return const TextBox();
                    },
                  )
                ],
              );
            }
            if (state is ChatLoadedState) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        Message message = state.messages[index];
                        return BubbleMessage(
                          userId: state.submitterUser.uid,
                          message: message,
                          animationController: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 200),
                          ),
                        );
                      },
                      itemCount: state.messages.length,
                    ),
                  ),
                  const Divider(height: 1),
                  BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      return const TextBox();
                    },
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

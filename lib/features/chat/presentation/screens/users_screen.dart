import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/chat/domain/entities/server_status.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/user/user_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/widgets/custom_list_view.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        leading: IconButton(
          onPressed: () {
            context.read<UserBloc>().add(const UserDisconnectionEvent());
            context.read<LoginBloc>().add(LogoutUserEvent());
            Navigator.popAndPushNamed(context, 'login');
          },
          icon: const Icon(Icons.exit_to_app_rounded),
        ),
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadedState) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: state.serverStatus == ServerStatus.online
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        )
                      : const Icon(
                          Icons.offline_bolt,
                          color: Colors.red,
                        ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: const CustomListView(),
    );
  }
}

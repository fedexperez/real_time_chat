import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/users/users_bloc.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: const WaterDropHeader(
        complete: Icon(Icons.check),
      ),
      onRefresh: () {
        context.read<UsersBloc>().add(const UsersGetEvent());
        _refreshController.refreshCompleted();
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
          if (loginState is LoginLoadedState) {
            return BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is UsersInitialState || state is UsersLoadingState) {
                  return const Center(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressIndicator(
                            strokeWidth: 8.0,
                          )),
                    ),
                  );
                }
                if (state is UsersLoadedState) {
                  final List<User> users = state.usersResponse.users;
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final User receptorUser = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(receptorUser.name.substring(0, 2)),
                        ),
                        title: Text(receptorUser.name),
                        subtitle: Text(receptorUser.email),
                        trailing: (receptorUser.online)
                            ? Icon(
                                Icons.circle,
                                color: Colors.green.shade300,
                              )
                            : Icon(
                                Icons.circle,
                                color: Colors.red.shade600,
                              ),
                        onTap: () {
                          context.read<ChatBloc>().add(ChatLoadEvent(
                                receptorUser: receptorUser,
                                submitterUser: loginState.user,
                              ));
                          Navigator.pushNamed(context, 'chat');
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: users.length,
                  );
                }
                if (state is UsersErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }
                return Container();
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/authentication/presentation/widgets/widgets.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/user/user_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/users/users_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
            child: SizedBox(
              height: size.height * 0.8,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(),
                  _Form(),
                  const Labels(
                    route: 'register',
                    title: '¿No tienes cuenta?',
                    subtitle: 'Crea una ahora!',
                  ),
                  const Text('Terminos y condiciones'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadedState) {
            context.read<UserBloc>().add(const UserConnectionEvent());
            context.read<UsersBloc>().add(const UsersGetEvent());
            Navigator.popAndPushNamed(context, 'users', arguments: state.user);
          }
          if (state is LoginErrorState) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text('Error'),
                  content: Text('prueba de nuevo'),
                );
              },
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<LoginBloc>();
          if (state is LoginInitialState) {
            return Column(
              children: [
                CustomTextField(
                  iconData: Icons.email,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textController: emailCtrl,
                ),
                CustomTextField(
                  iconData: Icons.password,
                  hintText: 'Clave',
                  obscureText: true,
                  textController: passCtrl,
                ),
                CustomFilledFormButton(
                  buttonText: 'Ingresar',
                  onPressed: () {
                    bloc.add(
                      LogUserEvent(
                        email: emailCtrl.text,
                        password: passCtrl.text,
                      ),
                    );
                  },
                ),
              ],
            );
          }
          if (state is LoginLoadingState) {
            return Column(
              children: [
                CustomTextField(
                  iconData: Icons.email,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textController: emailCtrl,
                ),
                CustomTextField(
                  iconData: Icons.password,
                  hintText: 'Clave',
                  obscureText: true,
                  textController: passCtrl,
                ),
                const CustomFilledFormButton(
                  buttonText: 'Logging in',
                  onPressed: null,
                ),
              ],
            );
          }
          if (state is LoginErrorState) {
            return Column(
              children: [
                CustomTextField(
                  iconData: Icons.email,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textController: emailCtrl,
                ),
                CustomTextField(
                  iconData: Icons.password,
                  hintText: 'Clave',
                  obscureText: true,
                  textController: passCtrl,
                ),
                CustomFilledFormButton(
                  buttonText: 'Ingresar',
                  onPressed: () {
                    bloc.add(
                      LogUserEvent(
                        email: emailCtrl.text,
                        password: passCtrl.text,
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

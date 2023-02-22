import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/register/register_bloc.dart';

import 'package:real_time_chat/features/authentication/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                  const Logo(
                    title: 'Registro',
                  ),
                  _Form(),
                  const Labels(
                    route: 'login',
                    title: '¿Ya tienes una cuenta?',
                    subtitle: 'Ingresa ahora!',
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadedState) {
            Navigator.popAndPushNamed(context, 'login');
            print('registred');
          }
          if (state is RegisterErrorState) {
            if (state.errorMessage == Constants.connectionFailureMessage) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(state.errorMessage),
                    content: Text('Revisa tu conexion'),
                  );
                },
              );
            }
            if (state.errorMessage == Constants.serverFailureMessage) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(state.errorMessage),
                    content: Text(
                        'Revisa si el correo que intentas utilizar ya esta registrado, de lo contrario revisa que la clave sea correcta'),
                  );
                },
              );
            }
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegisterBloc>();
          if (state is RegisterInitialState) {
            return Column(
              children: [
                CustomTextField(
                  iconData: Icons.person,
                  hintText: 'Nombre',
                  textInputType: TextInputType.emailAddress,
                  textController: nameCtrl,
                ),
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
                  textController: passwordCtrl,
                ),
                CustomFilledFormButton(
                  buttonText: 'Registrarme',
                  onPressed: () {
                    // final bloc = sl<LoginBloc>();
                    // final bloc = context.read<LoginBloc>();
                    print(emailCtrl.text);
                    print(passwordCtrl.text);
                    bloc.add(
                      RegisterUserEvent(
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      ),
                    );
                  },
                ),
              ],
            );
          }
          if (state is RegisterLoadingState) {
            return Column(
              children: [
                CustomTextField(
                  iconData: Icons.person,
                  hintText: 'Nombre',
                  textInputType: TextInputType.emailAddress,
                  textController: nameCtrl,
                ),
                CustomTextField(
                  iconData: Icons.person,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textController: emailCtrl,
                ),
                CustomTextField(
                  iconData: Icons.password,
                  hintText: 'Clave',
                  obscureText: true,
                  textController: passwordCtrl,
                ),
                const CustomFilledFormButton(
                  buttonText: 'Registrarme',
                  onPressed: null,
                ),
              ],
            );
          }
          if (state is RegisterErrorState) {
            return Column(
              children: [
                CustomTextField(
                  iconData: Icons.person,
                  hintText: 'Nombre',
                  textInputType: TextInputType.emailAddress,
                  textController: nameCtrl,
                ),
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
                  textController: passwordCtrl,
                ),
                CustomFilledFormButton(
                  buttonText: 'Registrarme',
                  onPressed: () {
                    print(emailCtrl.text);
                    print(passwordCtrl.text);
                    bloc.add(
                      RegisterUserEvent(
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
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

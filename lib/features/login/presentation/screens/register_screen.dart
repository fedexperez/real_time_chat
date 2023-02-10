import 'package:flutter/material.dart';

import 'package:real_time_chat/features/login/presentation/widgets/widgets.dart';

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
                children: const [
                  Logo(
                    title: 'Registro',
                  ),
                  _Form(),
                  Labels(
                    route: 'login',
                    title: '¿Ya tienes una cuenta?',
                    subtitle: 'Ingresa ahora!',
                  ),
                  Text('Terminos y condiciones'),
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
  const _Form();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const CustomTextField(
            iconData: Icons.email,
            hintText: 'Email',
            textInputType: TextInputType.emailAddress,
          ),
          const CustomTextField(
            iconData: Icons.password,
            hintText: 'Clave',
          ),
          CustomFilledFormButton(
            buttonText: 'Registrarme',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

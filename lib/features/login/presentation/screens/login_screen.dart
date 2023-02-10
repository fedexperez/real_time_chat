import 'package:flutter/material.dart';

import 'package:real_time_chat/features/login/presentation/widgets/widgets.dart';

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
                children: const [
                  Logo(),
                  _Form(),
                  _Labels(),
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
  const _Form({super.key});

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
            buttonText: 'Ingresar',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            '¿No tienes cuenta?',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Crea una ahora!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}

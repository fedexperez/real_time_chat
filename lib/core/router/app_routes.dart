import 'package:flutter/material.dart';

import 'package:real_time_chat/features/authentication/presentation/screens/login_screen.dart';
import 'package:real_time_chat/features/authentication/presentation/screens/register_screen.dart';

class AppRoutes {
  static const initialRoute = 'register';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'register': (BuildContext context) => const RegisterScreen(),
  };
}

import 'package:flutter/material.dart';

import 'package:real_time_chat/features/login/presentation/screens/login_screen.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
  };
}

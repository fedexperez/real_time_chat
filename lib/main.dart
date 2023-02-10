import 'package:flutter/material.dart';

import 'package:real_time_chat/core/router/app_routes.dart';
import 'package:real_time_chat/core/themes/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      theme: AppTheme.ligthTheme,
      title: 'Real Time Chat',
    );
  }
}

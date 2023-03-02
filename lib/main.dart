import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:real_time_chat/injection_container.dart';
import 'package:real_time_chat/core/router/app_routes.dart';
import 'package:real_time_chat/core/themes/app_theme.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/register/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>()..add(LoginTokenCheckEvent()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => sl<RegisterBloc>(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

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

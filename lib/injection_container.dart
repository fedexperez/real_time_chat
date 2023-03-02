import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:real_time_chat/core/secure_storage/secure_storage.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/check_logged_user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:real_time_chat/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/login_user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/register_user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/register/register_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Features
  //Bloc
  sl.registerFactory(() => LoginBloc(loginUser: sl(), checkLoggedUser: sl()));
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));

  //Usecases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));
  sl.registerLazySingleton(() => CheckLoggedUser(repository: sl()));

  //Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: sl(),
      secureStorage: sl(),
    ),
  );

  //Data
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(client: sl()),
  );

  ///Core
  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(sl()));

  ///External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}

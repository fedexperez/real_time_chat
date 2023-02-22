import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:real_time_chat/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/login_user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/register_user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/register/register_bloc.dart';

final sl = GetIt.instance;

// void init() async {
Future<void> init() async {
  ///Features
  //Bloc
  sl.registerFactory(() => LoginBloc(loginUser: sl()));
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));

  //Usecases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));

  //Repository
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(authenticationRemoteDataSource: sl()));

  //Data
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(client: sl()),
  );

  ///Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///External
  ///Now SharedPreferences are type shared preferences an not type Future
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}

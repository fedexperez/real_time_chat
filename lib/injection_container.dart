import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;

import 'package:real_time_chat/core/constants/environment.dart';
import 'package:real_time_chat/core/secure_storage/secure_storage.dart';
import 'package:real_time_chat/core/services/socket_service.dart';
import 'package:real_time_chat/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:real_time_chat/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/check_logged_user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/login_user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/register_user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/register/register_bloc.dart';
import 'package:real_time_chat/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:real_time_chat/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:real_time_chat/features/chat/domain/usecases/chat_user_connection.dart';
import 'package:real_time_chat/features/chat/domain/usecases/chat_user_disconnection.dart';
import 'package:real_time_chat/features/chat/domain/usecases/get_messages.dart';
import 'package:real_time_chat/features/chat/domain/usecases/get_users.dart';
import 'package:real_time_chat/features/chat/domain/usecases/receive_message.dart';
import 'package:real_time_chat/features/chat/domain/usecases/send_message.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/message/message_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/user/user_bloc.dart';
import 'package:real_time_chat/features/chat/presentation/blocs/users/users_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Features
  ///Authentication
  //Bloc
  sl.registerFactory(() => LoginBloc(
        loginUser: sl(),
        checkLoggedUser: sl(),
      ));
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

  ///Chat
  //Bloc
  sl.registerFactory(() => UserBloc(
        chatUserConnection: sl(),
        chatUserDisconnection: sl(),
      ));
  sl.registerFactory(() => UsersBloc(getUsers: sl()));
  sl.registerFactory(() => ChatBloc(receiveMessage: sl(), getMessages: sl()));
  sl.registerFactory(() => MessageBloc(sendMessage: sl()));

  //Usecases
  sl.registerLazySingleton(() => ChatUserConnection(repository: sl()));
  sl.registerLazySingleton(() => ChatUserDisconnection(repository: sl()));
  sl.registerLazySingleton(() => GetUsers(repository: sl()));
  sl.registerLazySingleton(() => SendMessage(repository: sl()));
  sl.registerLazySingleton(() => ReceiveMessage(repository: sl()));
  sl.registerLazySingleton(() => GetMessages(repository: sl()));

  //Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      socketService: sl(),
      secureStorage: sl(),
      chatRemoteDataSource: sl(),
    ),
  );

  //Data
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(client: sl(), socket: sl()),
  );

  ///Core
  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(sl()));
  sl.registerLazySingleton<SocketService>(() => SocketServiceImpl(
        secureStorage: sl(),
        socket: sl(),
      ));

  ///External
  io.Socket socket = io.io(
    Environment.socketUrl,
    io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .enableForceNew()
        .build(),
  );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => socket);
}

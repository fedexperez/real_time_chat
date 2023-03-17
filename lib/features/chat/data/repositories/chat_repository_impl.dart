import 'package:dartz/dartz.dart';

import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/secure_storage/secure_storage.dart';
import 'package:real_time_chat/core/services/socket_service.dart';
import 'package:real_time_chat/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/entities/server_status.dart';
import 'package:real_time_chat/features/chat/domain/entities/users_response.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final SocketService socketService;
  final SecureStorage secureStorage;
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({
    required this.socketService,
    required this.secureStorage,
    required this.chatRemoteDataSource,
  });

  @override
  Future<Either<Failure, ServerStatus>> chatUserConnection() async {
    try {
      final connectionResponse = await socketService.chatUserConnection();
      return Right(connectionResponse);
    } on SocketException {
      return Left(SocketFailure());
    }
  }

  @override
  Either<Failure, ServerStatus> chatUserDisconnection() {
    try {
      final connectionResponse = socketService.chatUserDisconnection();
      secureStorage.removeUserToken();
      return Right(connectionResponse);
    } on SocketException {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, UsersResponse>> getUsers({int startFrom = 0}) async {
    try {
      final userToken = await secureStorage.getSecuredUserToken();
      final usersResponse = await chatRemoteDataSource.getUsers(userToken);
      return Right(usersResponse);
    } on ServerException {
      return Left(ServerFailure());
    } on ConnectionException {
      return Left(SocketFailure());
    }
  }

  @override
  Either<Failure, void> sendMessage(Message message) {
    try {
      final usersResponse = chatRemoteDataSource.sendMessage(message);
      return Right(usersResponse);
    } on ServerException {
      return Left(ServerFailure());
    } on ConnectionException {
      return Left(SocketFailure());
    }
  }

  @override
  Either<Failure, Message> receiveMessage() {
    try {
      final messageReceived = socketService.receiveMessage();
      return Right(messageReceived);
    } on SocketException {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(String fromUser) async {
    try {
      final userToken = await secureStorage.getSecuredUserToken();
      final messagesReceived = await chatRemoteDataSource.getMessages(
        userToken,
        fromUser,
      );
      return Right(messagesReceived);
    } on SocketException {
      return Left(SocketFailure());
    }
  }
}

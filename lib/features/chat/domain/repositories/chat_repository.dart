import 'package:dartz/dartz.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/entities/server_status.dart';
import 'package:real_time_chat/features/chat/domain/entities/users_response.dart';

abstract class ChatRepository {
  Future<Either<Failure, ServerStatus>> chatUserConnection();
  Either<Failure, ServerStatus> chatUserDisconnection();
  Future<Either<Failure, UsersResponse>> getUsers({int startFrom});
  Either<Failure, void> sendMessage(Message message);
  Either<Failure, Message> receiveMessage();
  Future<Either<Failure, List<Message>>> getMessages(String fromUser);
}

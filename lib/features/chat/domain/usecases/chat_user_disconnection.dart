import 'package:dartz/dartz.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/chat/domain/entities/server_status.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';

class ChatUserDisconnection implements UseCase<ServerStatus, NoParams> {
  final ChatRepository repository;

  ChatUserDisconnection({required this.repository});

  @override
  Future<Either<Failure, ServerStatus>> call(NoParams params) async {
    return repository.chatUserDisconnection();
  }
}

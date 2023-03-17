import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';

class ReceiveMessage implements UseCase<Message, NoParams> {
  final ChatRepository repository;

  ReceiveMessage({required this.repository});

  @override
  Future<Either<Failure, Message>> call(NoParams params) async {
    return repository.receiveMessage();
  }
}

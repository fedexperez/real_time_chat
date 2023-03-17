import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';

class GetMessages implements UseCase<List<Message>, Params> {
  final ChatRepository repository;

  GetMessages({required this.repository});

  @override
  Future<Either<Failure, List<Message>>> call(Params params) async {
    return repository.getMessages(params.fromUser);
  }
}

class Params extends Equatable {
  final String fromUser;

  const Params({
    required this.fromUser,
  });

  @override
  List<Object?> get props => [fromUser];
}

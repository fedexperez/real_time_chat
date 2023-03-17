import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';

class SendMessage implements UseCase<void, Params> {
  final ChatRepository repository;

  SendMessage({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return repository.sendMessage(params.message);
  }
}

class Params extends Equatable {
  final Message message;

  const Params({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

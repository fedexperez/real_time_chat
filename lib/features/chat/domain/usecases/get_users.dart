import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/chat/domain/entities/users_response.dart';
import 'package:real_time_chat/features/chat/domain/repositories/chat_repository.dart';

class GetUsers implements UseCase<UsersResponse, Params> {
  final ChatRepository repository;

  GetUsers({required this.repository});

  @override
  Future<Either<Failure, UsersResponse>> call(Params params) async {
    return repository.getUsers();
  }
}

class Params extends Equatable {
  final int? startFrom;

  const Params({
    this.startFrom,
  });

  @override
  List<Object?> get props => [startFrom];
}

import 'package:dartz/dartz.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';

class CheckLoggedUser implements UseCase<AuthenticationResponse, NoParams> {
  final AuthenticationRepository repository;

  CheckLoggedUser({required this.repository});

  @override
  Future<Either<Failure, AuthenticationResponse>> call(NoParams params) async {
    return await repository.checkLoggedUser();
  }
}

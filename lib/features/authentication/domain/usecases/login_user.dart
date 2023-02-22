import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';

class LoginUser implements UseCase<AuthenticationResponse, Params> {
  final AuthenticationRepository repository;

  LoginUser({required this.repository});

  @override
  Future<Either<Failure, AuthenticationResponse>> call(Params params) async {
    return await repository.loginUser(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

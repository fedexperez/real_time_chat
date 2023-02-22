import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/core/usecase/usecase.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';

class RegisterUser implements UseCase<AuthenticationResponse, Params> {
  final AuthenticationRepository repository;

  RegisterUser({required this.repository});

  @override
  Future<Either<Failure, AuthenticationResponse>> call(Params params) async {
    return await repository.registerUser(
      params.name,
      params.email,
      params.password,
    );
  }
}

class Params extends Equatable {
  final String name;
  final String email;
  final String password;

  const Params({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

import 'package:dartz/dartz.dart';

import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationResponse>> loginUser(
    String email,
    String password,
  );

  Future<Either<Failure, AuthenticationResponse>> registerUser(
    String name,
    String email,
    String password,
  );

  Future<Either<Failure, AuthenticationResponse>> checkLoggedUser();
}

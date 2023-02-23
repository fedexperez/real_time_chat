import 'package:dartz/dartz.dart';

import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/core/errors/failures.dart';
import 'package:real_time_chat/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImpl({required this.authenticationRemoteDataSource});

  @override
  Future<Either<Failure, AuthenticationResponse>> loginUser(
      String email, String password) async {
    try {
      final authenticationResponse =
          await authenticationRemoteDataSource.loginUser(email, password);
      return Right(authenticationResponse);
    } on ServerException {
      return Left(ServerFailure());
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponse>> registerUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final registerResponse =
          await authenticationRemoteDataSource.registerUser(
        name,
        email,
        password,
      );
      return Right(registerResponse);
    } on ServerException {
      return Left(ServerFailure());
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }
}

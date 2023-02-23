import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/core/errors/failures.dart';

import 'package:real_time_chat/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:real_time_chat/features/authentication/data/models/authentication_response_model.dart';
import 'package:real_time_chat/features/authentication/data/models/user_model.dart';
import 'package:real_time_chat/features/authentication/data/repositories/authentication_repository_impl.dart';

import 'authentication_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthenticationRemoteDataSource>(
      as: #BaseMockAuthenticationRemoteDataSource)
])
void main() {
  late AuthenticationRepositoryImpl repositoryImpl;
  late BaseMockAuthenticationRemoteDataSource mockRemoteDataSource;
  late UserModel userModel;
  late AuthenticationResponseModel authenticationResponseModel;
  late String name;
  late String email;
  late String password;

  setUp(() {
    mockRemoteDataSource = BaseMockAuthenticationRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: mockRemoteDataSource,
    );
    name = 'Fernando';
    email = 'test3@test.com';
    password = '12345';
    userModel = UserModel(
      name: name,
      email: email,
      online: false,
      uid: 'fftt',
    );
    authenticationResponseModel = AuthenticationResponseModel(
      ok: true,
      user: userModel,
      token: 'testToken',
    );
  });

  group('registerUserGroup', () {
    group('device is online', () {
      test(
        'should return remote data when the call to remote data source is succesfull',
        () async {
          //arrange
          when(mockRemoteDataSource.registerUser(name, email, password))
              .thenAnswer((_) async => authenticationResponseModel);
          //act
          final result =
              await repositoryImpl.registerUser(name, email, password);
          //assert
          verify(mockRemoteDataSource.registerUser(name, email, password));
          expect(result, equals(Right(authenticationResponseModel)));
        },
      );

      test(
        'should return connection failure when the call to remote data source is unsuccesfull',
        () async {
          //arrange
          when(mockRemoteDataSource.loginUser(email, password))
              .thenThrow(ServerException());
          //act
          final result = await repositoryImpl.loginUser(email, password);
          //assert
          verify(mockRemoteDataSource.loginUser(email, password));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      test(
        'should return connection failure when could not connect to the server',
        () async {
          //arrange
          when(mockRemoteDataSource.loginUser(email, password))
              .thenThrow(ConnectionException());
          //act
          final result = await repositoryImpl.loginUser(email, password);
          //assert
          verify(mockRemoteDataSource.loginUser(email, password));
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });

  group('loginUserGroup', () {
    group('device&server is online', () {
      test(
        'should return remote data when the call to remote data source is succesfull',
        () async {
          //arrange
          when(mockRemoteDataSource.loginUser(email, password))
              .thenAnswer((_) async => authenticationResponseModel);
          //act
          final result = await repositoryImpl.loginUser(email, password);
          //assert
          verify(mockRemoteDataSource.loginUser(email, password));
          expect(result, equals(Right(authenticationResponseModel)));
        },
      );

      test(
        'should return connection failure when the call to remote data source is unsuccesfull',
        () async {
          //arrange
          when(mockRemoteDataSource.loginUser(email, password))
              .thenThrow(ServerException());
          //act
          final result = await repositoryImpl.loginUser(email, password);
          //assert
          verify(mockRemoteDataSource.loginUser(email, password));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device/server is offline', () {
      test(
        'should return connection failure when could not connect to the server',
        () async {
          //arrange
          when(mockRemoteDataSource.loginUser(email, password))
              .thenThrow(ConnectionException());
          //act
          final result = await repositoryImpl.loginUser(email, password);
          //assert
          verify(mockRemoteDataSource.loginUser(email, password));
          expect(result, equals(Left(ConnectionFailure())));
        },
      );
    });
  });
}

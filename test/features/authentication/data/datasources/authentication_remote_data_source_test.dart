import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:real_time_chat/features/authentication/data/models/authentication_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'authentication_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthenticationRemoteDataSourceImpl authenticationRemoteDataSourceImpl;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    authenticationRemoteDataSourceImpl =
        AuthenticationRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String wrongEmail = 'wrongTest@wrongTest.com';
  const String wrongPassword = 'wrong';

  const String name = 'Fernando';
  const String email = 'test3@test.com';
  const String password = '12345';

  void setUpMockHttpClientGetSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('authentication_response.json'), 200),
    );
  }

  void setUpMockHttpClientPostSuccess200() {
    when(
      mockHttpClient.post(
        any,
        body: anyNamed('body'),
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(fixture('authentication_response.json'), 200),
    );
  }

  void setUpMockHttpClientGetFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  void setUpMockHttpClientPostFailure404() {
    when(
      mockHttpClient.post(any,
          body: anyNamed('body'), headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('loginUser', () {
    final authenticationResponseModel = AuthenticationResponseModel.fromJson(
        fixture('authentication_response.json'));

    //TODO: PUEDE SER POR SER LOCALHOST
    // test(
    //   'should perform a POST request on a URL with application/json header',
    //   () async {
    //     //arrange
    //     setUpMockHttpClientPostSuccess200();
    //     //act
    //     await authenticationRemoteDataSourceImpl.loginUser(email, password);
    //     //assert
    //     verify(await mockHttpClient.post(
    //       Uri.http('localhost:3000', '/api/login'),
    //       body: jsonEncode({'email': email, 'password': password}),
    //       headers: {'Content-type': 'application/json'},
    //     ));
    //   },
    // );

    test(
      'should return a authentication result when the response code is 200 (success)',
      () async {
        //arrange
        setUpMockHttpClientPostSuccess200();
        //act
        final result =
            await authenticationRemoteDataSourceImpl.loginUser(email, password);
        //assert
        expect(result, isA<AuthenticationResponseModel>());
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        //arrange
        setUpMockHttpClientPostFailure404();
        //act
        final call = authenticationRemoteDataSourceImpl.loginUser;
        //assert
        expect(() => call(wrongEmail, wrongPassword),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw a ConnectionException when could not connect to the Server',
      () async {
        //arrange
        setUpMockHttpClientGetFailure404();
        //act
        final call = authenticationRemoteDataSourceImpl.loginUser;
        //assert
        expect(() => call(wrongEmail, wrongPassword),
            throwsA(const TypeMatcher<ConnectionException>()));
      },
    );
  });

  group('registerUser', () {
    //TODO: PUEDE SER POR SER LOCALHOST
    // test(
    //   'should perform a POST request on a URL with application/json header',
    //   () async {
    //     //arrange
    //     setUpMockHttpClientPostSuccess200();
    //     //act
    //     authenticationRemoteDataSourceImpl.loginUser(email, password);
    //     //assert
    //     verify(mockHttpClient.post(
    //       Uri.http('localhost:3000', '/api/login'),
    //       body: jsonEncode(body),
    //       headers: {'Content-type': 'application/json'},
    //     ));
    //   },
    // );

    test(
      'should return a authentication result when the response code is 200 (success)',
      () async {
        //arrange
        setUpMockHttpClientPostSuccess200();
        //act
        final result = await authenticationRemoteDataSourceImpl.registerUser(
          name,
          email,
          password,
        );
        //assert
        expect(result, isA<AuthenticationResponseModel>());
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        //arrange
        setUpMockHttpClientPostFailure404();
        //act
        final call = authenticationRemoteDataSourceImpl.registerUser;
        //assert
        expect(() => call(name, email, password),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw a ConnectionException when could not connect to the Server',
      () async {
        //arrange
        setUpMockHttpClientGetFailure404();
        //act
        final call = authenticationRemoteDataSourceImpl.registerUser;
        //assert
        expect(() => call(name, email, password),
            throwsA(const TypeMatcher<ConnectionException>()));
      },
    );
  });
}

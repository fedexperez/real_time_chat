import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/register_user.dart';

import 'login_user_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late RegisterUser usecase;
  late MockUserRepository mockUserRepository;
  late String name;
  late String email;
  late String password;
  late AuthenticationResponse authenticationResponse;
  late User user;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = RegisterUser(repository: mockUserRepository);
    name = 'Fernando';
    email = 'test3@test.com';
    password = '12345';
    user = User(online: false, name: 'Fernando', email: email, uid: 'ffpp');
    authenticationResponse =
        AuthenticationResponse(ok: true, user: user, token: 'testToken');
  });

  test(
    'should return an authentication response',
    () async {
      //arrange
      when(mockUserRepository.registerUser(name, email, password))
          .thenAnswer((realInvocation) async => Right(authenticationResponse));
      //act
      final result =
          await usecase(Params(name: name, email: email, password: password));
      //assert
      expect(result, equals(Right(authenticationResponse)));
      verify(mockUserRepository.registerUser(name, email, password));
    },
  );
}

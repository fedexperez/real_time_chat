import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/entities/user.dart';

import 'package:real_time_chat/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/login_user.dart';

import 'login_user_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late LoginUser usecase;
  late MockAuthenticationRepository mockUserRepository;
  late String email;
  late String password;
  late AuthenticationResponse authenticationResponse;
  late User user;

  setUp(() {
    mockUserRepository = MockAuthenticationRepository();
    usecase = LoginUser(repository: mockUserRepository);
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
      when(mockUserRepository.loginUser(email, password))
          .thenAnswer((realInvocation) async => Right(authenticationResponse));
      //act
      final result = await usecase(Params(email: email, password: password));
      //assert
      expect(result, equals(Right(authenticationResponse)));
      verify(mockUserRepository.loginUser(email, password));
    },
  );
}

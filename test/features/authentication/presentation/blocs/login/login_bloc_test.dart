import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/entities/user.dart';

import 'package:real_time_chat/features/authentication/domain/usecases/login_user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/login/login_bloc.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUser])
void main() {
  late MockLoginUser mockLoginUser;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUser = MockLoginUser();
    loginBloc = LoginBloc(loginUser: mockLoginUser);
  });

  const String email = 'test3@test.com';
  const String password = '12345';

  const AuthenticationResponse authenticationResponse = AuthenticationResponse(
      ok: true,
      user: User(
        online: true,
        name: 'Fernando',
        email: email,
        uid: 'fftt',
      ),
      token: 'testToken');

  test(
    'initialState should be empty',
    () async {
      //assert
      expect(loginBloc.state, equals(LoginInitialState()));
    },
  );

  group('LogUser', () {
    test(
      'should get data from the concrete use case',
      () async {
        //arrange
        when(mockLoginUser(const Params(email: email, password: password)))
            .thenAnswer((_) async => const Right(authenticationResponse));
        //act
        loginBloc.add(const LogUserEvent(email: email, password: password));
        await untilCalled(
          mockLoginUser(const Params(email: email, password: password)),
        );
        //assert
        verify(mockLoginUser(const Params(email: email, password: password)));
      },
    );

    test(
      'should emit [LoadingState, LoadedState] when data is gotten succesfully',
      () async* {
        //arrange
        when(mockLoginUser(const Params(email: email, password: password)))
            .thenAnswer((_) async => const Right(authenticationResponse));
        //assert later
        final List<LoginState> expected = [
          LoginInitialState(),
          LoginLoadingState(),
          LoginLoadedState(user: authenticationResponse.user),
        ];
        expectLater(loginBloc.state, emitsInOrder(expected));
        //act
        loginBloc.add(const LogUserEvent(email: email, password: password));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when getting data fails',
      () async* {
        //arrange
        when(mockLoginUser(const Params(email: email, password: password)))
            .thenAnswer((_) async => const Right(authenticationResponse));
        //assert later
        final List<LoginState> expected = [
          LoginInitialState(),
          LoginLoadingState(),
          const LoginErrorState(errorMessage: Constants.serverFailureMessage),
        ];
        expectLater(loginBloc.state, emitsInOrder(expected));
        //act
        loginBloc.add(const LogUserEvent(email: email, password: password));
      },
    );
  });
}

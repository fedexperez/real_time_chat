import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/domain/usecases/register_user.dart';
import 'package:real_time_chat/features/authentication/presentation/blocs/register/register_bloc.dart';

import 'register_bloc.mocks.dart';

@GenerateMocks([RegisterUser])
void main() {
  late MockRegisterUser mockRegisterUser;
  late RegisterBloc registerBloc;

  setUp(() {
    mockRegisterUser = MockRegisterUser();
    registerBloc = RegisterBloc(registerUser: mockRegisterUser);
  });

  const String name = 'Fernando';
  const String email = 'test3@test.com';
  const String password = '12345';

  const AuthenticationResponse authenticationResponse = AuthenticationResponse(
      ok: true,
      user: User(
        online: true,
        name: name,
        email: email,
        uid: 'fftt',
      ),
      token: 'testToken');

  test(
    'initialState should be empty',
    () async {
      //assert
      expect(registerBloc.state, equals(RegisterInitialState()));
    },
  );

  group('RegisterUser', () {
    test(
      'should get data from the concrete use case',
      () async {
        //arrange
        when(mockRegisterUser(
                const Params(name: name, email: email, password: password)))
            .thenAnswer((_) async => const Right(authenticationResponse));
        //act
        registerBloc.add(const RegisterUserEvent(
            name: name, email: email, password: password));
        await untilCalled(
          mockRegisterUser(
              const Params(name: name, email: email, password: password)),
        );
        //assert
        verify(mockRegisterUser(
            const Params(name: name, email: email, password: password)));
      },
    );

    test(
      'should emit [LoadingState, LoadedState] when data is gotten succesfully',
      () async* {
        //arrange
        when(mockRegisterUser(
                const Params(name: name, email: email, password: password)))
            .thenAnswer((_) async => const Right(authenticationResponse));
        //assert later
        final List<RegisterState> expected = [
          RegisterInitialState(),
          RegisterLoadingState(),
          RegisterLoadedState(user: authenticationResponse.user),
        ];
        expectLater(registerBloc.state, emitsInOrder(expected));
        //act
        registerBloc.add(const RegisterUserEvent(
            name: name, email: email, password: password));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when getting data fails',
      () async* {
        //arrange
        when(mockRegisterUser(
                const Params(name: name, email: email, password: password)))
            .thenAnswer((_) async => const Right(authenticationResponse));
        //assert later
        final List<RegisterState> expected = [
          RegisterInitialState(),
          RegisterLoadingState(),
          const RegisterErrorState(
              errorMessage: Constants.serverFailureMessage),
        ];
        expectLater(registerBloc.state, emitsInOrder(expected));
        //act
        registerBloc.add(const RegisterUserEvent(
            name: name, email: email, password: password));
      },
    );
  });
}

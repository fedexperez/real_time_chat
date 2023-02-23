import 'package:flutter_test/flutter_test.dart';

import 'package:real_time_chat/features/authentication/data/models/authentication_response_model.dart';
import 'package:real_time_chat/features/authentication/domain/entities/authentication_response.dart';
import 'package:real_time_chat/features/authentication/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const UserModel userModel = UserModel(
    name: 'Fernando',
    email: 'test3@test.com',
    online: false,
    uid: 'fftt',
  );

  const AuthenticationResponseModel authenticationResponseModel =
      AuthenticationResponseModel(
    ok: true,
    user: userModel,
    token: 'testToken',
  );

  test(
    'should be a subclass of Authentication Response entity',
    () async {
      //assert
      expect(authenticationResponseModel, isA<AuthenticationResponse>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        //arrange
        final json = fixture('authentication_response.json');
        //act
        final result = AuthenticationResponseModel.fromJson(json);
        //assert
        expect(result, authenticationResponseModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = authenticationResponseModel.toMap();
        //assert
        final expectedMap = {
          "ok": true,
          "user": UserModel,
          "token": "testToken"
        };
        expect(result, expectedMap);
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:real_time_chat/features/authentication/domain/entities/user.dart';
import 'package:real_time_chat/features/authentication/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const UserModel userModel = UserModel(
    name: 'Fernando',
    email: 'test3@test.com',
    online: false,
    uid: 'fftt',
  );

  test(
    'should be a subclass of User entity',
    () async {
      //assert
      expect(userModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        //arrange
        final json = fixture('user.json');
        //act
        final result = UserModel.fromJson(json);
        //assert
        expect(result, userModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = userModel.toMap();
        //assert
        final expectedMap = {
          'name': 'Fernando',
          'email': 'test3@test.com',
          'online': false,
          'uid': 'fftt',
        };
        expect(result, expectedMap);
      },
    );
  });
}

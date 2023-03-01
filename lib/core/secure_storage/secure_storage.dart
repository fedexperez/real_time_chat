import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:real_time_chat/core/constants/constants.dart';
import 'package:real_time_chat/core/errors/exceptions.dart';

abstract class SecureStorage {
  Future<String> getSecuredUserToken();
  Future<void> secureUserToken({required String tokenToSecure});
  Future<void> removeUserToken();
}

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorageImpl(this.flutterSecureStorage);

  @override
  Future<String> getSecuredUserToken() async {
    final token = await flutterSecureStorage.read(key: Constants.token);
    if (token != null) {
      return token;
    } else {
      throw TokenException();
    }
  }

  @override
  Future<void> secureUserToken({required String tokenToSecure}) async {
    await flutterSecureStorage.write(
        key: Constants.token, value: tokenToSecure);
  }

  @override
  Future<void> removeUserToken() async {
    await flutterSecureStorage.delete(key: Constants.token);
  }
}

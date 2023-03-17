import 'dart:io';

class Environment {
  static String apiUrl = Platform.isIOS ? 'localhost:3001' : '10.0.2.2:3001';
  static String socketUrl =
      Platform.isIOS ? 'http://localhost:3001' : 'http://10.0.2.2:3001';
}

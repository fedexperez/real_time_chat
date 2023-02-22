import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/features/authentication/data/models/authentication_response_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthenticationResponseModel> loginUser(String email, String password);
  Future<AuthenticationResponseModel> registerUser(
      String name, String email, String password);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final http.Client client;
  final String _baseUrl = 'localhost:3000';

  AuthenticationRemoteDataSourceImpl({required this.client});

  Future<String> _postJsonData(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final url = Uri.http(_baseUrl, endPoint);
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ServerException();
      }
    } on ServerException {
      throw ServerException();
    } catch (error) {
      throw ConnectionException();
    }
  }

  // @override
  // Future<UserModel> loginUser(String email, String password) async {
  //   final jsonData = await _postJsonData(
  //     '/api/login',
  //     {
  //       'email': email,
  //       'password': password,
  //     },
  //   );
  //   final response = AuthenticationResponseModel.fromJson(jsonData);
  //   final loggedUser = response.user as UserModel;
  //   return loggedUser;
  // }

  @override
  Future<AuthenticationResponseModel> loginUser(
      String email, String password) async {
    final jsonData = await _postJsonData(
      '/api/login',
      {
        'email': email,
        'password': password,
      },
    );
    final response = AuthenticationResponseModel.fromJson(jsonData);
    return response;
  }

  // @override
  // Future<UserModel> registerUser(
  //     String name, String email, String password) async {
  //   final jsonData = await _postJsonData(
  //     '/api/login/new',
  //     {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //     },
  //   );
  //   final response = AuthenticationResponseModel.fromJson(jsonData);
  //   final loggedUser = response.user as UserModel;
  //   return loggedUser;
  // }

  @override
  Future<AuthenticationResponseModel> registerUser(
      String name, String email, String password) async {
    final jsonData = await _postJsonData(
      '/api/login/new',
      {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    final response = AuthenticationResponseModel.fromJson(jsonData);
    return response;
  }
}

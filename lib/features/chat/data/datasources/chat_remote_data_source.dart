import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:real_time_chat/features/chat/data/models/messages_from_user_response.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:real_time_chat/core/constants/environment.dart';
import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/features/chat/data/models/users_response_model.dart';
import 'package:real_time_chat/features/chat/domain/entities/message.dart';
import 'package:real_time_chat/features/chat/domain/entities/users_response.dart';

abstract class ChatRemoteDataSource {
  Future<UsersResponse> getUsers(String userToken, {int startFrom});
  void sendMessage(Message message);
  Future<List<Message>> getMessages(String userToken, String fromUser);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final http.Client client;
  final io.Socket socket;

  ChatRemoteDataSourceImpl({required this.client, required this.socket});

  Future<String> _postJsonData(
    String endPoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final url = Uri.http(Environment.apiUrl, endPoint);
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

  Future<String> _getJsonData(String endPoint, String userToken,
      {int startFrom = 0}) async {
    try {
      final url = Uri.http(Environment.apiUrl, endPoint);
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'x-token': userToken,
          'startFrom': '$startFrom'
        },
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

  @override
  Future<UsersResponse> getUsers(String userToken, {int startFrom = 0}) async {
    final jsonData =
        await _getJsonData('/api/users', userToken, startFrom: startFrom);
    final users = UsersResponseModel.fromJson(jsonData);
    return users;
  }

  @override
  void sendMessage(Message message) {
    try {
      socket.emit('personal-message', {
        'fromUser': message.fromUser,
        'toUser': message.toUser,
        'text': message.text,
      });
    } catch (error) {
      throw SocketException();
    }
  }

  @override
  Future<List<Message>> getMessages(String userToken, String fromUser) async {
    final jsonData = await _getJsonData(
      '/api/messages/$fromUser',
      userToken,
    );
    final messages = MessagesFromUserResponseModel.fromJson(jsonData).messages;
    return messages;
  }
}

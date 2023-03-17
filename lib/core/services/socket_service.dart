import 'package:real_time_chat/core/errors/exceptions.dart';
import 'package:real_time_chat/core/secure_storage/secure_storage.dart';
import 'package:real_time_chat/features/chat/data/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:real_time_chat/features/chat/domain/entities/server_status.dart';

abstract class SocketService {
  Future<ServerStatus> chatUserConnection();
  ServerStatus chatUserDisconnection();
  MessageModel receiveMessage();
}

class SocketServiceImpl extends SocketService {
  final SecureStorage secureStorage;
  late io.Socket socket;
  ServerStatus serverStatus = ServerStatus.connecting;

  SocketServiceImpl({required this.secureStorage, required this.socket});

  @override
  Future<ServerStatus> chatUserConnection() async {
    final String token = await secureStorage.getSecuredUserToken();

    socket.onConnect((_) {
      serverStatus = ServerStatus.online;
      print('se conecto la cosa');
    });

    socket.onDisconnect((_) {
      serverStatus = ServerStatus.offline;
      print('se peto cosa');
    });

    socket.on(
      'personal-message',
      (data) {
        print('Tengo mensaje $data');
      },
    );

    try {
      socket.io.options['extraHeaders'] = {'x-token': token};
      socket.connect();

      //Lo de aqui lo deberia quitar
      serverStatus = ServerStatus.online;
      return serverStatus;
    } catch (e) {
      throw SocketException();
    }
  }

  @override
  ServerStatus chatUserDisconnection() {
    try {
      socket.disconnect();
      serverStatus = ServerStatus.offline;
      return serverStatus;
    } catch (e) {
      throw SocketException();
    }
  }

  @override
  MessageModel receiveMessage() {
    MessageModel receivedMessage =
        const MessageModel(text: '', fromUser: '', toUser: '');
    try {
      socket.on(
        'personal-message',
        (data) {
          print('Mensaje recibido $data');
          receivedMessage = MessageModel.fromMap(data);
          print(receivedMessage.text);
          return receivedMessage;
        },
      );
      return receivedMessage;
    } catch (e) {
      throw SocketException();
    }
  }
}

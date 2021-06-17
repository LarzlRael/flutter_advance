import 'package:flutter/material.dart';
import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  late IO.Socket _socket;

  IO.Socket get socket => _socket;
  Function get emit => this._socket.emit;

  ServerStatus get serverStatus => this._serverStatus;
  // SocketService() {
  //   this._initConfig();
  // }

  void connect() async {
    final token = await AuthService.getToken();
    // Dart client
    this._socket = IO.io(
        Enviroments.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()// disable auto-connection
            .enableForceNew()
            .setExtraHeaders({
              'foo': 'bar',
              'x-token': token,
            }) // optional
            .build());

    this._socket.on('connect', (_) {
      print('connected socket success');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      print('offline sockets');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje :$payload');
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}

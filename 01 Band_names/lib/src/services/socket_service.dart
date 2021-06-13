import 'package:flutter/material.dart';
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
  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    print('trying conect');
    // IO.Socket socket = IO.io('http://192.168.0.10:3000', {
    //   'transports': ['websocket'],
    //   'autoConnect': true,
    // });

    this._socket = IO.io(
        'http://192.168.0.10:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    this._socket.on('connect', (_) {
      print('Conectado papu');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      print('offline papu');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje :$payload');
    });
  }
}

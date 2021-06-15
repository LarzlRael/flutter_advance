import 'dart:io';

class Enviroments {
  static String apiUrl = Platform.isAndroid
      ? 'https://backend-chat-server.herokuapp.com/api'
      : 'https://backend-chat-server.herokuapp.com/api';
  static String socketUrl = Platform.isAndroid
      ? 'https://backend-chat-server.herokuapp.com'
      : 'https://backend-chat-server.herokuapp.com';
}

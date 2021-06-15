import 'package:flutter/foundation.dart';
import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/models/mensajes_reponse.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future getChat(String usuarioId) async {
    final resp = await http
        .get(Uri.parse('${Enviroments.apiUrl}/mensajes/$usuarioId'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}

import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/models/usuarios_response.dart';
import 'package:realtime_chat/services/auth_service.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuario() async {
    try {
      final resp = await http.get(Uri.parse('${Enviroments.apiUrl}/usuarios'),
          headers: {
            'Content-type': 'application/json',
            'x-token': await AuthService.getToken()
          });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}

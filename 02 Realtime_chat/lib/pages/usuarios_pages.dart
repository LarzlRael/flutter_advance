import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socker_services.dart';
import 'package:realtime_chat/services/usuarios_service.dart';
import 'package:realtime_chat/utils/utils.dart';

import 'package:realtime_chat/helpers/mostrar_alerta.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarioService = new UsuariosService();
  List<Usuario> usuarios = [];

  // final usuarios = [
  //   Usuario(
  //     online: true,
  //     email: 'rey_@gmail.com',
  //     nombre: 'rey',
  //     uid: 'xxdxd',
  //   ),
  //   Usuario(
  //     online: false,
  //     email: 'gato@gmail.com',
  //     nombre: 'gatotom',
  //     uid: 'xxdxdx',
  //   ),
  //   Usuario(
  //     online: true,
  //     email: 'miguel@gmail.com',
  //     nombre: 'miky',
  //     uid: '123',
  //   ),
  // ];
  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(toCapitalize(usuario.nombre),
            style: TextStyle(color: Colors.black54)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black54),
          onPressed: () {
            // mostrarAlertaCerrarSesion(context, logout);
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.offline_bolt, color: Colors.red))
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsuarios(),
        onRefresh: _cargarUsuarios,
        enablePullDown: true,
      ),
    );
  }

  void logout() {
    final socketService = Provider.of<SocketService>(context);

    socketService.disconnect();
    AuthService.deleteToken();
    Navigator.pushReplacementNamed(context, 'login');
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(toCapitalize(usuario.nombre)),
      subtitle: Text(toCapitalize(usuario.email)),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : null,
          // : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getUsuario();
    setState(() {});
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

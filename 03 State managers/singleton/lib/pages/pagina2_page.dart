import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singleton/models/usuario.dart';
import 'package:singleton/services/usuario_service.dart';

class Pagina2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of<UsuarioService>(context);
    return Scaffold(
      appBar: AppBar(
        title: usuarioService.existeUsuario
            ? Text('Nombre ${usuarioService.usuario.nombre}')
            : Text('Pagina 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              child: Text(
                'Establecer Usuario',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                final newUser = Usuario(
                  nombre: 'Larzdosan',
                  edad: 20,
                  profesiones: [
                    'Fullstack developer',
                    'video jugador experto :F'
                  ],
                  show: true,
                );
                usuarioService.setUsuario = newUser;
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                usuarioService.cambiarEdad(45);
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text(
                'Añadir profesion',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: usuarioService.agregarProfesion,
            ),
          ],
        ),
      ),
    );
  }
}

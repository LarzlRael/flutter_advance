import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singleton/block/usuario/usuario_bloc.dart';
import 'package:singleton/models/usuario.dart';
import 'package:singleton/services/usuario_service.dart';

class Pagina2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioBloc = BlocProvider.of<UsuarioBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 2'),
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
                usuarioBloc.add(ActivadorUsuario(newUser));
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text(
                'Cambiar Edad',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print('cambiendo edad');
                usuarioBloc.add(CambiarEdad(69));
              },
            ),
            MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Añadir profesion',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  usuarioBloc.add(AgregarProfesion('Nuevo profesion'));
                }),
          ],
        ),
      ),
    );
  }
}

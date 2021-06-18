import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:singleton/models/usuario.dart';
import 'package:singleton/pages/pagina2_page.dart';
import 'package:singleton/pages/pagina1_page.dart';
import 'package:singleton/services/usuario_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => new UsuarioService(
                    usuario: Usuario(
                  nombre: 'rey',
                  edad: 10,
                  profesiones: [],
                  show: false,
                ))),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'pagina1',
          routes: {
            'pagina1': (_) => Pagina1Page(),
            'pagina2': (_) => Pagina2Page(),
          }),
    );
  }
}

import 'package:brand_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('emiting message');
          socketService.emit(
            'emitir-mensaje',
            {'nombre': 'flutter', 'mensaje': 'hi from flutter!!'},
          );
        },
        child: Icon(Icons.message),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ServerStatus ${socketService.serverStatus}'),
          ],
        ),
      ),
    );
  }
}

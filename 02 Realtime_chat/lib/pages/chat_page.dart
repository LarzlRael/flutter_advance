import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/models/mensajes_reponse.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socker_services.dart';
import 'package:realtime_chat/utils/utils.dart';
import 'package:realtime_chat/widget/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatservice;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    this.chatservice = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(this.chatservice.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioId) async {
    List<Mensaje> chat = await this.chatservice.getChat(usuarioId);

    final history = chat.map((m) => ChatMessage(
          text: m.mensaje,
          uid: m.de,
          createdAt:
              "${m.createdAt.hour - 4}:${m.createdAt.minute.toString().length == 1 ? '0${m.createdAt.minute}' : '${m.createdAt.minute}'} ",
          animationController: AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 0),
          )..forward(),
        ));

    setState(() {
      this._messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    print(payload['mensaje']);

    ChatMessage message = new ChatMessage(
      text: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  List<ChatMessage> _messages = [];
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    // final usuarioPara = chatService.usuarioPara;
    final usuarioPara = this.chatservice.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black54, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(usuarioPara.nombre.substring(0, 2).toUpperCase(),
                  style: TextStyle(fontSize: 16)),
              backgroundColor: Colors.blue[100],
              maxRadius: 16,
            ),
            SizedBox(height: 3),
            Text(
              toCapitalize(usuarioPara.nombre),
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (text) {
                  setState(() {
                    if (text.trim().length > 0) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
            // Button to send

            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              child: (Platform.isIOS)
                  ? CupertinoButton(
                      child: Text('enviar'),
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: _isWriting
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                          icon: Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.trim().length == 0) return;
    // print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: authService.usuario.uid,
      text: text,
      createdAt:
          "${(DateTime.now().hour - 4)}:${DateTime.now().minute.toString().length == 1 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}'} ",
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    this.socketService.emit('mensaje-personal', {
      'de': this.authService.usuario.uid,
      'para': this.chatservice.usuarioPara.uid,
      'mensaje': text
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}

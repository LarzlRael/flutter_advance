import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:realtime_chat/global/enviroment.dart';
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _authtecating = false;
  // create storage
  final _storage = FlutterSecureStorage();

  bool get autenticando => this._authtecating;
  set autenticando(bool valor) {
    this._authtecating = valor;
    notifyListeners();
  }

  // token static getters

  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      Uri.parse('${Enviroments.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );

    print(resp.body);
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    this.autenticando = true;

    final data = {
      'nombre': name,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Enviroments.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );

    print(resp.body);
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggenIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(
      Uri.parse('${Enviroments.apiUrl}/login/renew'),
      headers: {
        'Content-type': 'application/json',
        'x-token': token != null ? token : '',
      },
    );
    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this._logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async {
    await _storage.delete(key: 'token');
  }
}

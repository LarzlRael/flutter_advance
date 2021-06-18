import 'package:flutter/material.dart';
import 'package:singleton/models/usuario.dart';

class UsuarioService with ChangeNotifier {
  Usuario usuario;

  UsuarioService({required this.usuario});

  Usuario get getUsuario => this.usuario;
  bool get existeUsuario => this.usuario.show ? true : false;

  set setUsuario(Usuario user) {
    this.usuario = user;
    notifyListeners();
  }

  // void cambiarEdad(int edad) {
  //   this.usuario.edad = edad;
  //   notifyListeners();
  // }

  // void removeUsuario() {
  //   this.usuario.show = false;
  //   notifyListeners();
  // }

  // void agregarProfesion() {
  //   this
  //       .usuario
  //       .profesiones
  //       .add('profesion ${this.usuario.profesiones.length + 1}');
  //   notifyListeners();
  // }
}

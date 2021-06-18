part of 'usuario_bloc.dart';

@immutable
@immutable
abstract class UsuarioEvent {}

class ActivadorUsuario extends UsuarioEvent {
  final Usuario usuario;

  ActivadorUsuario(this.usuario);
}

class CambiarEdad extends UsuarioEvent {
  final int edad;
  CambiarEdad(this.edad);
}

class AgregarProfesion extends UsuarioEvent {
  final String profesion;
  AgregarProfesion(this.profesion);
}

class BorrarUsuario extends UsuarioEvent {}

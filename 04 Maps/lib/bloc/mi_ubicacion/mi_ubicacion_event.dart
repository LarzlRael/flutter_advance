part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class onUbicacionCambio extends MiUbicacionEvent {
  final LatLng ubicacion;

  onUbicacionCambio(this.ubicacion);
}

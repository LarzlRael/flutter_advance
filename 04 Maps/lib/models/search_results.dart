import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResults {
  final bool cancelo;
  final bool manual;
  final LatLng? posistion;
  final String? nombreDestino;
  final String? descripcion;

  SearchResults({
    required this.cancelo,
    this.manual = false,
    this.posistion,
    this.nombreDestino,
    this.descripcion,
  });
}

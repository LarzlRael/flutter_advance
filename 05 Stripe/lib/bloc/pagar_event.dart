part of 'pagar_bloc.dart';

@immutable
abstract class PagarEvent {}

class OnSellecionTarjeta extends PagarEvent {
  final TarjetaCredito tarjeta;

  OnSellecionTarjeta(this.tarjeta);
}

class OnDesactivarTarjeta extends PagarEvent {}

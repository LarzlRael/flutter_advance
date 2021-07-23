part of 'pagar_bloc.dart';

@immutable
class PagarState {
  final double montoPagar;
  final String moneda;
  final bool tarjeaActiva;
  final TarjetaCredito? tarjeta;

  PagarState({
    this.montoPagar = 375.55,
    this.moneda = 'USD',
    this.tarjeaActiva = false,
    this.tarjeta,
  });

  PagarState copyWith({
    double? montoPagar,
    String? moneda,
    bool? tarjeaActiva,
    TarjetaCredito? tarjeta,
  }) =>
      PagarState(
        montoPagar: montoPagar ?? this.montoPagar,
        moneda: moneda ?? this.moneda,
        tarjeaActiva: tarjeaActiva ?? this.tarjeaActiva,
        tarjeta: tarjeta ?? this.tarjeta,
      );
}

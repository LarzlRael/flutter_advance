import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe/models/tarjeta_credito.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(PagarState());

  @override
  Stream<PagarState> mapEventToState(
    PagarEvent event,
  ) async* {
    if (event is OnSellecionTarjeta) {
      yield state.copyWith(tarjeaActiva: true, tarjeta: event.tarjeta);
    } else {
      yield state.copyWith(tarjeaActiva: false);
    }
  }
}

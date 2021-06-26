part of 'widgets.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(builder: (context, state) {
      if (state.seleccionManual) {
        return Container();
      } else {
        return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context));
      }
    });
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: width,
      child: GestureDetector(
        onTap: () async {
          print('buscaando ....');

          final proximidad = context.read<MiUbicacionBloc>().state.ubicacion;
          final historial = context.read<BusquedaBloc>().state.historial;

          final resultado = await showSearch(
              context: context,
              delegate: SearchDestination(proximidad!, historial));
          this.retornoBusqueda(context, resultado!);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          width: double.infinity,
          child: Text('¿Donde quieres ir ?',
              style: TextStyle(color: Colors.black87)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> retornoBusqueda(
      BuildContext context, SearchResults result) async {
    print('cancelo: ${result.cancelo}');
    print('manual: ${result.manual}');

    if (result.cancelo) return;
    if (result.manual) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }
    calculandoAlert(context);

    // calcular la ruta en base al valor: Result
    final trafficService = new TrafficService();
    final mapaBloc = context.read<MapaBloc>();

    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.posistion;

    final drivingResponse =
        await trafficService.getCoordsInicioAndFin(inicio!, destino!);

    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;
    final nombreDestino = result.nombreDestino;
    PolylinePoints polylinePoints = PolylinePoints();
    final points = polylinePoints.decodePolyline(geometry);

    final List<LatLng> rutaCoordenadas = points
        .map((point) => LatLng(point.latitude / 10, point.longitude / 10))
        .toList();
    print(rutaCoordenadas);
    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoordenadas, distance, duration, nombreDestino!));

    Navigator.of(context).pop();

    //Agregar al historial
    final busquedaBloc = context.read<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));
  }
}

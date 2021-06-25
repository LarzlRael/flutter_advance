part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (BuildContext context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  context
                      .read<BusquedaBloc>()
                      .add(OnDesActivarMarcadorManual());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
              from: 200,
              child: Icon(Icons.location_on, size: 50),
            ),
          ),
        ),

        // Boton de confimar destino

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: Text('Confirmar destino',
                  style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
              onPressed: () {
                this.calcularDestino(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlert(context);

    final traficService = new TrafficService();

    final mapaBloc = context.read<MapaBloc>();
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = mapaBloc.state.ubicacionCentral;

    final trafficResponse =
        await traficService.getCoordsInicioAndFin(inicio!, destino!);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;

    //decodificar los puntos geometry
    // final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    PolylinePoints polylinePoints = PolylinePoints();
    final points = polylinePoints.decodePolyline(geometry);
    print('puntos : $points');
    //Decodificar los puntos del geometry
    final List<LatLng> rutaCoordenadas = points
        .map((point) => LatLng(point.latitude / 10, point.longitude / 10))
        .toList();
    print(rutaCoordenadas);
    mapaBloc
        .add(OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duration));

    Navigator.of(context).pop();
    context.read<BusquedaBloc>().add(OnDesActivarMarcadorManual());
  }
}

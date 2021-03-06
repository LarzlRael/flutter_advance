import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/bloc/mapa/mapa_bloc.dart';
import 'package:maps/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:maps/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state) => crearMapa(state),
          ),
          Positioned(
            top: 15,
            child: SafeArea(child: Searchbar()),
          ),
          MarcadorManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion!)
      return Center(
        child: CircularProgressIndicator(),
      );

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion!));
    // return Center(
    //     child: Text(
    //         '${state.ubicacion!.latitude}, ${state.ubicacion!.longitude}'));
    final cameraPosition = CameraPosition(target: state.ubicacion!, zoom: 15);
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          compassEnabled: false,
          // mapType: MapType.normal,
          // myLocationButtonEnabled: true,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) =>
              mapaBloc.initMapa(controller),
          polylines: mapaBloc.state.polylines.values.toSet(),
          onCameraMove: (cameraPosition) {
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
          markers: mapaBloc.state.markers.values.toSet(),
        );
      },
    );
  }
}

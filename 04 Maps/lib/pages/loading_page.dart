import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:maps/helpers/helpers.dart';
import 'package:maps/pages/acceso_gps_page.dart';
import 'package:maps/pages/mapa_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    print('=====> $state');
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }

  Future checkGpsYLocation(BuildContext context) async {
    // TODO permisoGPS
    final permisoGPS = await Permission.location.isGranted;
    // TODO gps esta activo
    final gpsActive = await Geolocator.Geolocator.isLocationServiceEnabled();

    if (permisoGPS && gpsActive) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if (!permisoGPS) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es mecesario el permiso del gps';
    } else {
      return 'Active el gps';
    }
    // print('Loading page hola mundo !!!');
    // Navigator.pushReplacement(
    //     context, navegarMapaFadeIn(context, AccesoGpsPage()));
  }
}

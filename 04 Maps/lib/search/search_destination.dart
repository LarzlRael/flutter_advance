import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/models/search_response.dart';
import 'package:maps/models/search_results.dart';
import 'package:maps/services/trafic_service.dart';

class SearchDestination extends SearchDelegate<SearchResults> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficservice;
  final LatLng proximidad;
  final List<SearchResults> historial;

  SearchDestination(this.proximidad, this.historial)
      : this.searchFieldLabel = 'Buscar',
        this._trafficservice = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          this.query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        this.close(context, SearchResults(cancelo: true));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.trim().length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: () {
              print('manualmente');
              this.close(context, SearchResults(cancelo: false, manual: true));
            },
          ),
          ...this
              .historial
              .map((result) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(result.nombreDestino!),
                    subtitle: Text(result.descripcion!),
                    onTap: () {
                      this.close(context, result);
                    },
                  ))
              .toList(),
        ],
      );
    }
    return this._construirResultadosSugerencias();
  }

  Widget _construirResultadosSugerencias() {
    if (this.query.trim().length == 0) {
      return Container();
    }
    this._trafficservice.getSugerenciasPorQuery(this.query.trim(), proximidad);
    //  this
    //       ._trafficservice
    //       .getResultadosPorQuery(this.query.trim(), proximidad),
    return StreamBuilder(
      stream: this._trafficservice.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final lugares = snapshot.data!.features;

        if (lugares.length == 0) {
          return ListTile(
            title: Text('No hay resultados con $query'),
          );
        }

        return ListView.separated(
          itemCount: lugares.length,
          separatorBuilder: (_, i) => Divider(),
          itemBuilder: (_, i) {
            final lugar = lugares[i];

            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs),
              subtitle: Text(lugar.placeNameEs),
              onTap: () {
                this.close(
                  context,
                  SearchResults(
                    cancelo: false,
                    manual: false,
                    posistion: LatLng(lugar.center[1], lugar.center[0]),
                    nombreDestino: lugar.text,
                    descripcion: lugar.placeNameEs,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

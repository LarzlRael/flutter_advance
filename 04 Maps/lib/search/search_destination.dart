import 'package:flutter/material.dart';
import 'package:maps/models/search_results.dart';

class SearchDestination extends SearchDelegate<SearchResults> {
  @override
  final String searchFieldLabel;
  SearchDestination() : this.searchFieldLabel = 'Buscar';

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
    return Text('build results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Colocar ubicación manualmente'),
          onTap: () {
            print('manualmente');
            this.close(context, SearchResults(cancelo: false, manual: true));
          },
        )
      ],
    );
  }
}

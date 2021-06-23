part of 'widgets.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: width,
      child: GestureDetector(
        onTap: () async {
          print('buscaando ....');
          final resultado =
              await showSearch(context: context, delegate: SearchDestination());
          this.retornoBusqueda(resultado!);
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

  void retornoBusqueda(SearchResults result) {
    print('cancelo: ${result.cancelo}');
    print('manual: ${result.manual}');

    if (result.cancelo) return;
  }
}

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
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

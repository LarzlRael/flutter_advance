part of 'custom_markers.dart';

class MarkerDestinoPainter extends CustomPainter {
  final String description;
  final double metros;

  MarkerDestinoPainter(this.description, this.metros);

  @override
  void paint(Canvas canvas, Size size) {
    final double circuloNegroR = 20;
    final double circuloBlancoR = 7;

    Paint paint = new Paint()..color = Colors.black;

    //Dubujar el circulo negro

    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      20,
      paint,
    );

    // Circulo blanco

    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      circuloBlancoR,
      paint,
    );

    // Sombra
    final Path path = new Path();
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    // caja blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    // caja Negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //Dibujar textos
    double km = this.metros / 100;
    km = (km * 100).floorToDouble();
    TextSpan textspan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      text: '$km',
    );

    TextPainter textPainter = new TextPainter(
        text: textspan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(
        maxWidth: 70,
        minWidth: 70,
      );
    textPainter.paint(canvas, Offset(0, 35));

    //Dibujar textosMinutos
    textspan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: 'Km',
    );

    textPainter = new TextPainter(
        text: textspan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(
        maxWidth: 70,
      );

    textPainter.paint(canvas, Offset(20, 67));

    //Dibujar Mi Ubicacion
    textspan = TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      text: this.description,
    );

    textPainter = TextPainter(
      text: textspan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...',
    )..layout(
        maxWidth: size.width - 100,
      );

    textPainter.paint(canvas, Offset(90, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

part of 'helpers.dart';

void calculandoAlert(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Espere por favor'),
        content: Text('calculando ruta'),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Espere por favor'),
        content: Text('calculando ruta'),
      ),
    );
  }
}

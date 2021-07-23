part of 'helpers.dart';

mostrarLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Espere ...'),
      content: LinearProgressIndicator(),
    ),
  );
}

mostrarAlerta(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        )
      ],
    ),
  );
}

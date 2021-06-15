import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String title;
  final String subTitle;
  const Labels(
      {Key? key,
      required this.ruta,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.subTitle,
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 10),
        GestureDetector(
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushNamed(context, ruta);
          },
        ),
        Text(
          'Terminos y condicones de uso',
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}

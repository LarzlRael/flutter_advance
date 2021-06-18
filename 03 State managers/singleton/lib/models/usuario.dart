class Usuario {
  final String nombre;
  final int edad;
  final List<String> profesiones;
  final bool show;

  Usuario({
    required this.nombre,
    required this.edad,
    required this.profesiones,
    required this.show,
  });

  Usuario copyWith({
    String? nombre,
    int? edad,
    List<String>? profesiones,
    bool? show,
  }) =>
      Usuario(
        nombre: nombre ?? this.nombre,
        edad: edad ?? this.edad,
        profesiones: profesiones ?? this.profesiones,
        show: show ?? this.show,
      );
}

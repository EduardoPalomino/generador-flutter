class Rol {
  final String id;
  final String nombre;
  final String descripcion;
  const Rol({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      id: json["_id"]?.toString() ?? "",
      nombre: json["nombre"]?.toString() ?? "",
      descripcion: json["descripcion"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "nombre": nombre,
      "descripcion": descripcion,
    };
  }

}

class UserModel {
  final String id;
  final String nombre;
  final String password;
  final String email;
  final String rol_id;
  UserModel({
    required this.id,
    required this.nombre,
    required this.password,
    required this.email,
    required this.rol_id,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nombre: json["nombre"],
      password: json["password"],
      email: json["email"],
      rol_id: json["rol_id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "password": password,
      "email": email,
      "rol_id": rol_id,
    };
  }
}

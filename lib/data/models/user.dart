class UserModel {
  final String id;
  final String nombre;
  final String user;
  final String password;
  final String rol_id;
  UserModel({
    required this.id,
    required this.nombre,
    required this.user,
    required this.password,
    required this.rol_id,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nombre: json["nombre"],
      user: json["user"],
      password: json["password"],
      rol_id: json["rol_id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "user": user,
      "password": password,
      "rol_id": rol_id,
    };
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserRepo {
  final String baseUrl = "http://localhost:3009/users";

  Future<UserModel> getUser(String nombre) async {
    final result = await http.get(Uri.parse(baseUrl));
    if (result.statusCode != 200) throw Exception();
    final List<dynamic> response = json.decode(result.body);
    final List<UserModel> items = response.map((json) => UserModel.fromJson(json)).toList();
    return items.firstWhere((item) => item.nombre.toLowerCase() == nombre.toLowerCase(), orElse: () => throw Exception('user no encontrado'));
  }

  Future<List<UserModel>> getUsers() async {
    final result = await http.get(Uri.parse(baseUrl));
    if (result.statusCode != 200) throw Exception('Error al obtener datos');
    final List<dynamic> response = json.decode(result.body);
    return response.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel> getUserById(String id) async {
    final result = await http.get(Uri.parse('$baseUrl/$id'));
    if (result.statusCode != 200) throw Exception('user no encontrado');
    return UserModel.fromJson(json.decode(result.body));
  }

  Future<UserModel> createUser(UserModel data) async {
    final result = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data.toJson()),
    );
    if (result.statusCode != 201) throw Exception('Error al crear user');
    return UserModel.fromJson(json.decode(result.body));
  }

  Future<UserModel> updateUser(String id, UserModel data) async {
    final result = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data.toJson()),
    );
    if (result.statusCode != 200) throw Exception('Error al actualizar user');
    return UserModel.fromJson(json.decode(result.body));
  }

  Future<void> deleteUser(String id) async {
    final result = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (result.statusCode != 200) throw Exception('Error al eliminar user');
  }
}

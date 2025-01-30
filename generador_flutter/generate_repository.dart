import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty) {
    print("Uso: dart generate_repository.dart <nombre_modelo>");
    return;
  }

  final String modelName = args[0];
  final String funcName = "${modelName[0].toUpperCase()}${modelName.substring(1)}";
  final String className = "${modelName[0].toUpperCase()}${modelName.substring(1)}Model";
  final String repoName = "${modelName[0].toUpperCase()}${modelName.substring(1)}Repo";
  final String fileName = modelName.toLowerCase();

  final buffer = StringBuffer();

  buffer.writeln("import 'package:http/http.dart' as http;");
  buffer.writeln("import 'dart:convert';");
  buffer.writeln("import '../models/$fileName.dart';\n");

  buffer.writeln("class $repoName {");
  buffer.writeln("  final String baseUrl = \"http://localhost:3009/${modelName}s\";\n");

  buffer.writeln("  Future<$className> get$funcName(String nombre) async {");
  buffer.writeln("    final result = await http.get(Uri.parse(baseUrl));");
  buffer.writeln("    if (result.statusCode != 200) throw Exception();");
  buffer.writeln("    final List<dynamic> response = json.decode(result.body);");
  buffer.writeln("    final List<$className> items = response.map((json) => $className.fromJson(json)).toList();");
  buffer.writeln("    return items.firstWhere((item) => item.nombre.toLowerCase() == nombre.toLowerCase(), orElse: () => throw Exception('$modelName no encontrado'));");
  buffer.writeln("  }\n");

  buffer.writeln("  Future<List<$className>> get${funcName}s() async {");
  buffer.writeln("    final result = await http.get(Uri.parse(baseUrl));");
  buffer.writeln("    if (result.statusCode != 200) throw Exception('Error al obtener datos');");
  buffer.writeln("    final List<dynamic> response = json.decode(result.body);");
  buffer.writeln("    return response.map((json) => $className.fromJson(json)).toList();");
  buffer.writeln("  }\n");

  buffer.writeln("  Future<$className> get${funcName}ById(String id) async {");
  buffer.writeln("    final result = await http.get(Uri.parse('\$baseUrl/\$id'));");
  buffer.writeln("    if (result.statusCode != 200) throw Exception('$modelName no encontrado');");
  buffer.writeln("    return $className.fromJson(json.decode(result.body));");
  buffer.writeln("  }\n");

  buffer.writeln("  Future<$className> create$funcName($className data) async {");
  buffer.writeln("    final result = await http.post(");
  buffer.writeln("      Uri.parse('\$baseUrl/create'),");
  buffer.writeln("      headers: {'Content-Type': 'application/json'},");
  buffer.writeln("      body: json.encode(data.toJson()),");
  buffer.writeln("    );");
  buffer.writeln("    if (result.statusCode != 201) throw Exception('Error al crear $modelName');");
  buffer.writeln("    return $className.fromJson(json.decode(result.body));");
  buffer.writeln("  }\n");

  buffer.writeln("  Future<$className> update$funcName(String id, $className data) async {");
  buffer.writeln("    final result = await http.put(");
  buffer.writeln("      Uri.parse('\$baseUrl/update/\$id'),");
  buffer.writeln("      headers: {'Content-Type': 'application/json'},");
  buffer.writeln("      body: json.encode(data.toJson()),");
  buffer.writeln("    );");
  buffer.writeln("    if (result.statusCode != 200) throw Exception('Error al actualizar $modelName');");
  buffer.writeln("    return $className.fromJson(json.decode(result.body));");
  buffer.writeln("  }\n");

  buffer.writeln("  Future<void> delete$funcName(String id) async {");
  buffer.writeln("    final result = await http.delete(Uri.parse('\$baseUrl/delete/\$id'));");
  buffer.writeln("    if (result.statusCode != 200) throw Exception('Error al eliminar $modelName');");
  buffer.writeln("  }");

  buffer.writeln("}");

  // Crear archivo
  final file = File('../lib/data/repositories/$fileName\_repository.dart');

  try {
    await file.writeAsString(buffer.toString());
    print('Archivo ${fileName}_repository.dart generado exitosamente.');
  } catch (e) {
    print('Error al escribir en el archivo: \$e');
  }
}

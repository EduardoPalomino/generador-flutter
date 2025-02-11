import 'dart:io';

void main(List<String> args) async {
  if (args.length < 2) {
    print("Uso: dart generate_repository.dart <nombre_modelo> <campo1,campo2,...>");
    return;
  }

  final String modelName = args[0];
  final List<String> fields = args[1].split(',');
  final String className = "${modelName[0].toUpperCase()}${modelName.substring(1)}";
  final String repoName = "${className}Repository";
  final String fileName = modelName.toLowerCase();

  // Separar el campo 'id' (si existe)
  final bool hasId = fields.contains('id');
  final List<String> nonIdFields = fields.where((field) => field != 'id').toList();

  final buffer = StringBuffer();

  buffer.writeln("import '../models/$fileName.dart';");
  buffer.writeln("import 'dart:convert';");
  buffer.writeln("import 'package:http/http.dart' as http;\n");

  buffer.writeln("class $repoName {");
  buffer.writeln("  final String _baseUrl = 'http://localhost:3009/${className}s';\n");

  // Método GET
  buffer.writeln("  Future<List<$className>> get${className}s() async {");
  buffer.writeln("    final response = await http.get(Uri.parse(_baseUrl));");
  buffer.writeln("    if (response.statusCode == 200) {");
  buffer.writeln("      List<dynamic> data = json.decode(response.body);");
  buffer.writeln("      return data.map((json) => $className.fromJson(json)).toList();");
  buffer.writeln("    } else {");
  buffer.writeln("      throw Exception('Error al cargar ${modelName}s');");
  buffer.writeln("    }");
  buffer.writeln("  }\n");

  // Método ADD (excluyendo 'id')
  if (nonIdFields.isNotEmpty) {
    buffer.writeln("  Future<void> add$className(${nonIdFields.map((f) => "String $f").join(', ')}) async {");
    buffer.writeln("    final response = await http.post(");
    buffer.writeln("      Uri.parse('\$_baseUrl/create'),");
    buffer.writeln("      body: json.encode({");
    for (var field in nonIdFields) {
      buffer.writeln("        '$field': $field,");
    }
    buffer.writeln("      }),");
    buffer.writeln("      headers: {'Content-Type': 'application/json'},");
    buffer.writeln("    );");
    buffer.writeln("    print('Response status: \${response.statusCode}');");
    buffer.writeln("    print('Response body: \${response.body}');");
    buffer.writeln("    if (response.statusCode != 200) {");
    buffer.writeln("      throw Exception('Error al agregar ${modelName}');");
    buffer.writeln("    }");
    buffer.writeln("  }\n");
  }

  // Método UPDATE (incluyendo 'id')
  if (hasId && nonIdFields.isNotEmpty) {
    buffer.writeln("  Future<void> update$className(String id, ${nonIdFields.map((f) => "String $f").join(', ')}) async {");
    buffer.writeln("    final response = await http.put(");
    buffer.writeln("      Uri.parse('\$_baseUrl/update/\$id'),");
    buffer.writeln("      body: json.encode({");
    for (var field in nonIdFields) {
      buffer.writeln("        '$field': $field,");
    }
    buffer.writeln("      }),");
    buffer.writeln("      headers: {'Content-Type': 'application/json'},");
    buffer.writeln("    );");
    buffer.writeln("    if (response.statusCode != 200) {");
    buffer.writeln("      throw Exception('Error al actualizar ${modelName}');");
    buffer.writeln("    }");
    buffer.writeln("  }\n");
  }

  // Método DELETE
  if (hasId) {
    buffer.writeln("  Future<void> delete$className(String id) async {");
    buffer.writeln("    final response = await http.delete(Uri.parse('\$_baseUrl/delete/\$id'));");
    buffer.writeln("    print('REPOSITORY');");
    buffer.writeln("    print('Response delete$className: \${response.statusCode}');");
    buffer.writeln("    if (response.statusCode != 200) {");
    buffer.writeln("      throw Exception('Error al eliminar ${modelName}');");
    buffer.writeln("    }");
    buffer.writeln("  }");
  }

  buffer.writeln("}");

  // Crear archivo
  final file = File('../lib/data/repositories/$fileName\_repository.dart');

  try {
    await file.writeAsString(buffer.toString());
    print('Archivo ${fileName}_repository.dart generado exitosamente.');
  } catch (e) {
    print('Error al escribir en el archivo: $e');
  }
}
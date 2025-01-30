import 'dart:io';

void main(List<String> args) async {
  if (args.length < 2) {
    print("Uso: dart generate_model.dart <nombre_modelo> <campo1,campo2,campo3,...>");
    return;
  }

  final String modelName = args[0];
  final List<String> fields = args[1].split(',');

  final buffer = StringBuffer();

  // Generar la clase
  buffer.writeln('class ${modelName[0].toUpperCase()}${modelName.substring(1)}Model {');

  // Declarar los campos
  for (var field in fields) {
    buffer.writeln('  final String $field;');
  }

  // Constructor
  buffer.writeln('  ${modelName[0].toUpperCase()}${modelName.substring(1)}Model({');
  for (var field in fields) {
    buffer.writeln('    required this.$field,');
  }
  buffer.writeln('  });');

  // Método fromJson
  buffer.writeln('  factory ${modelName[0].toUpperCase()}${modelName.substring(1)}Model.fromJson(Map<String, dynamic> json) {');
  buffer.writeln('    return ${modelName[0].toUpperCase()}${modelName.substring(1)}Model(');
  for (var field in fields) {
    buffer.writeln('      $field: json["$field"],');
  }
  buffer.writeln('    );');
  buffer.writeln('  }');

  // Método toJson
  buffer.writeln('  Map<String, dynamic> toJson() {');
  buffer.writeln('    return {');
  for (var field in fields) {
    buffer.writeln('      "$field": $field,');
  }
  buffer.writeln('    };');
  buffer.writeln('  }');

  buffer.writeln('}');

  // Crear archivo
  final file = File('../lib/data/models/$modelName.dart');

  try {
    await file.writeAsString(buffer.toString());
    print('Archivo $modelName.dart generado exitosamente.');
  } catch (e) {
    print('Error al escribir en el archivo: $e');
  }
}

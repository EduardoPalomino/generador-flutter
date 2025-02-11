import 'dart:io';

void main(List<String> args) async {
  if (args.length < 2) {
    print("Uso: dart generate_bloc.dart <nombre_modelo> <campos>");
    return;
  }

  final String modelName = args[0];
  final List<String> fields = args[1].split(',');
  final List<String> fieldsNotId = args[1]
                                   .split(',')
                                   .where((field) => field != 'id') // Excluye "id"
                                   .toList();
  final String className = "${modelName[0].toUpperCase()}${modelName.substring(1)}";
  final String blocPath = '../lib/business_logic/blocs/$modelName';

  await Directory(blocPath).create(recursive: true);

  final Map<String, String> files = {
    "$blocPath/${modelName}_bloc.dart": "import 'dart:async';\n"
        "import 'package:flutter_bloc/flutter_bloc.dart';\n"
        "import 'package:equatable/equatable.dart';\n"
        "import '../../../data/models/$modelName.dart';\n"
        "import '../../../data/repositories/${modelName}_repository.dart';\n\n"
        "part '${modelName}_event.dart';\n"
        "part '${modelName}_state.dart';\n\n"
        "class ${className}Bloc extends Bloc<${className}Event, ${className}State> {\n"
        "  final ${className}Repository ${modelName}Repository;\n\n"
        "  ${className}Bloc(this.${modelName}Repository) : super(${className}InitialState()) {\n"
        "    on<Load${className}Event>(_onLoad${className});\n"
        "    on<Add${className}Event>(_onAdd${className});\n"
        "    on<Update${className}Event>(_onUpdate${className});\n"
        "    on<Delete${className}Event>(_onDelete${className});\n"
        "  }\n\n"
        "  Future<void> _onLoad${className}(Load${className}Event event, Emitter<${className}State> emit) async {\n"
        "    emit(${className}LoadingState());\n"
        "    try {\n"
        "      final items = await ${modelName}Repository.get${className}s();\n"
        "      emit(${className}SuccessState(items));\n"
        "    } catch (e) {\n"
        "      emit(${className}ErrorState(e.toString()));\n"
        "    }\n"
        "  }\n\n"
        "  Future<void> _onAdd${className}(Add${className}Event event, Emitter<${className}State> emit) async {\n"
        "    try {\n"
        "      await ${modelName}Repository.add${className}(${generateEventFields(fieldsNotId, 'event')});\n"
        "      await _reload${className}s(emit);\n"
        "    } catch (e) {\n"
        "      emit(${className}ErrorState(e.toString()));\n"
        "    }\n"
        "  }\n\n"
        "  Future<void> _onUpdate${className}(Update${className}Event event, Emitter<${className}State> emit) async {\n"
        "    try {\n"
        "      await ${modelName}Repository.update${className}(${generateEventFields(fields, 'event')});\n"
        "      await _reload${className}s(emit);\n"
        "    } catch (e) {\n"
        "      emit(${className}ErrorState(e.toString()));\n"
        "    }\n"
        "  }\n\n"
        "  Future<void> _onDelete${className}(Delete${className}Event event, Emitter<${className}State> emit) async {\n"
        "    try {\n"
        "      await ${modelName}Repository.delete${className}(event.id);\n"
        "      await _reload${className}s(emit);\n"
        "    } catch (e) {\n"
        "      emit(${className}ErrorState(e.toString()));\n"
        "    }\n"
        "  }\n\n"
        "  Future<void> _reload${className}s(Emitter<${className}State> emit) async {\n"
        "    emit(${className}LoadingState());\n"
        "    try {\n"
        "      final items = await ${modelName}Repository.get${className}s();\n"
        "      emit(${className}SuccessState(items));\n"
        "    } catch (e) {\n"
        "      emit(${className}ErrorState(e.toString()));\n"
        "    }\n"
        "  }\n"
        "}",

    "$blocPath/${modelName}_event.dart": "part of '${modelName}_bloc.dart';\n\n"
        "abstract class ${className}Event extends Equatable {\n"
        "  const ${className}Event();\n\n"
        "  @override\n"
        "  List<Object> get props => [];\n"
        "}\n\n"
        "class Load${className}Event extends ${className}Event {}\n\n"
        "class Add${className}Event extends ${className}Event {\n"
        "  ${generateEventFieldsDeclaration(fieldsNotId)}\n"
        "  Add${className}Event(${generateEventFieldsInitialization(fieldsNotId)});\n\n"
        "  @override\n"
        "  List<Object> get props => [${fieldsNotId.join(', ')}];\n"
        "}\n\n"
        "class Update${className}Event extends ${className}Event {\n"
        "  ${generateEventFieldsDeclaration(fields)}\n"
        "  Update${className}Event(${generateEventFieldsInitialization(fields)});\n\n"
        "  @override\n"
        "  List<Object> get props => [${fields.join(', ')}];\n"
        "}\n\n"
        "class Delete${className}Event extends ${className}Event {\n"
        "  final String id;\n"
        "  Delete${className}Event(this.id);\n\n"
        "  @override\n"
        "  List<Object> get props => [id];\n"
        "}",

    "$blocPath/${modelName}_state.dart": "part of '${modelName}_bloc.dart';\n\n"
        "abstract class ${className}State extends Equatable {\n"
        "  const ${className}State();\n\n"
        "  @override\n"
        "  List<Object> get props => [];\n"
        "}\n\n"
        "class ${className}InitialState extends ${className}State {}\n\n"
        "class ${className}LoadingState extends ${className}State {}\n\n"
        "class ${className}SuccessState extends ${className}State {\n"
        "  final List<${className}> ${modelName}s;\n"
        "  const ${className}SuccessState(this.${modelName}s);\n\n"
        "  @override\n"
        "  List<Object> get props => [${modelName}s];\n"
        "}\n\n"
        "class ${className}ErrorState extends ${className}State {\n"
        "  final String message;\n"
        "  ${className}ErrorState(this.message);\n\n"
        "  @override\n"
        "  List<Object> get props => [message];\n"
        "}"
  };

  for (var entry in files.entries) {
    final file = File(entry.key);
    await file.writeAsString(entry.value);
    print('Archivo ${entry.key} generado exitosamente.');
  }
}

String generateEventFieldsDeclaration(List<String> fields) {
  return fields.map((field) => "final String $field;").join('\n  ');
}

String generateEventFieldsInitialization(List<String> fields) {
  return fields.map((field) => "this.$field").join(', ');
}

String generateEventFields(List<String> fields, String eventName) {
  return fields.map((field) => "$eventName.$field").join(', ');
}
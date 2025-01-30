import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty) {
    print("Uso: dart generate_bloc.dart <nombre_modelo>");
    return;
  }

  final String modelName = args[0];
  final String className = "${modelName[0].toUpperCase()}${modelName.substring(1)}";
  final String blocPath = '../lib/business_logic/blocs/$modelName';

  await Directory(blocPath).create(recursive: true);

  final Map<String, String> files = {
    "$blocPath/${modelName}_bloc.dart": "import 'package:bloc/bloc.dart';\n"
        "import 'package:equatable/equatable.dart';\n"
        "import '../../../data/models/$modelName.dart';\n"
        "import '../../../data/repositories/${modelName}_repository.dart';\n"
        "part '${modelName}_event.dart';\n"
        "part '${modelName}_state.dart';\n\n"
        "class ${className}Bloc extends Bloc<${className}Event, ${className}State> {\n"
        "  final ${className}Repo ${modelName}Repo;\n"
        "  ${className}Bloc({required this.${modelName}Repo}) : super(${className}IsNotSearched()) {\n"
        "    on<${className}Event>((event, emit) async {\n"
        "      if (event is Fech${className}) {\n"
        "        emit(${className}IsLoading());\n"
        "        try {\n"
        "          final ${modelName} = await ${modelName}Repo.get${className}(event.nombre);\n"
        "          emit(${className}IsLoaded(${modelName}, event.nombre));\n"
        "        } catch (_) {\n"
        "          emit(${className}IsNotLoaded());\n"
        "        }\n"
        "      } else if (event is Reset${className}) {\n"
        "        emit(${className}IsNotSearched());\n"
        "      }\n"
        "    });\n"
        "  }\n"
        "}",

    "$blocPath/${modelName}_event.dart": "part of '${modelName}_bloc.dart';\n\n"
        "class ${className}Event extends Equatable {\n"
        "  const ${className}Event();\n"
        "  @override\n"
        "  List<Object?> get props => [];\n"
        "}\n\n"
        "class Fech${className} extends ${className}Event {\n"
        "  final String nombre;\n"
        "  Fech${className}({required this.nombre});\n"
        "  Map<String, String> get get${className} => {'nombre': nombre};\n"
        "  @override\n"
        "  List<Object?> get props => [nombre];\n"
        "}\n\n"
        "class Reset${className} extends ${className}Event {}",

    "$blocPath/${modelName}_state.dart": "part of '${modelName}_bloc.dart';\n\n"
        "class ${className}State extends Equatable {\n"
        "  const ${className}State();\n"
        "  @override\n"
        "  List<Object> get props => [];\n"
        "}\n\n"
        "class ${className}IsNotSearched extends ${className}State {}\n\n"
        "class ${className}IsLoading extends ${className}State {}\n\n"
        "class ${className}IsLoaded extends ${className}State {\n"
        "  final dynamic _$modelName;\n"
        "  final dynamic nombre;\n"
        "  const ${className}IsLoaded(this._$modelName, this.nombre);\n"
        "  ${className}Model get get${className} => _$modelName;\n"
        "  @override\n"
        "  List<Object> get props => [_$modelName, nombre];\n"
        "}\n\n"
        "class ${className}IsNotLoaded extends ${className}State {}"
  };

  for (var entry in files.entries) {
    final file = File(entry.key);
    await file.writeAsString(entry.value);
    print('Archivo ${entry.key} generado exitosamente.');
  }
}

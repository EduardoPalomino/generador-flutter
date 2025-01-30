part of 'rol_bloc.dart';

class RolState extends Equatable {
  const RolState();
  @override
  List<Object> get props => [];
}

class RolIsNotSearched extends RolState {}

class RolIsLoading extends RolState {}

class RolIsLoaded extends RolState {
  final dynamic _rol;
  final dynamic nombre;
  const RolIsLoaded(this._rol, this.nombre);
  RolModel get getRol => _rol;
  @override
  List<Object> get props => [_rol, nombre];
}

class RolIsNotLoaded extends RolState {}
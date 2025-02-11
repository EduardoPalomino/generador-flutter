part of 'rol_bloc.dart';

abstract class RolEvent extends Equatable {
  const RolEvent();

  @override
  List<Object> get props => [];
}

class LoadRolEvent extends RolEvent {}

class AddRolEvent extends RolEvent {
  final String nombre;
  final String descripcion;
  AddRolEvent(this.nombre, this.descripcion);

  @override
  List<Object> get props => [nombre, descripcion];
}

class UpdateRolEvent extends RolEvent {
  final String id;
  final String nombre;
  final String descripcion;
  UpdateRolEvent(this.id, this.nombre, this.descripcion);

  @override
  List<Object> get props => [id, nombre, descripcion];
}

class DeleteRolEvent extends RolEvent {
  final String id;
  DeleteRolEvent(this.id);

  @override
  List<Object> get props => [id];
}
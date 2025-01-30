part of 'rol_bloc.dart';

class RolEvent extends Equatable {
  const RolEvent();
  @override
  List<Object?> get props => [];
}

class FechRol extends RolEvent {
  final String nombre;
  FechRol({required this.nombre});
  Map<String, String> get getRol => {'nombre': nombre};
  @override
  List<Object?> get props => [nombre];
}

class ResetRol extends RolEvent {}
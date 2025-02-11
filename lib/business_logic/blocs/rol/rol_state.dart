part of 'rol_bloc.dart';

abstract class RolState extends Equatable {
  const RolState();

  @override
  List<Object> get props => [];
}

class RolInitialState extends RolState {}

class RolLoadingState extends RolState {}

class RolSuccessState extends RolState {
  final List<Rol> rols;
  const RolSuccessState(this.rols);

  @override
  List<Object> get props => [rols];
}

class RolErrorState extends RolState {
  final String message;
  RolErrorState(this.message);

  @override
  List<Object> get props => [message];
}
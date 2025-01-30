part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class FechUser extends UserEvent {
  final String nombre;
  FechUser({required this.nombre});
  Map<String, String> get getUser => {'nombre': nombre};
  @override
  List<Object?> get props => [nombre];
}

class ResetUser extends UserEvent {}
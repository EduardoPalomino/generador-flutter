part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserIsNotSearched extends UserState {}

class UserIsLoading extends UserState {}

class UserIsLoaded extends UserState {
  final dynamic _user;
  final dynamic nombre;
  const UserIsLoaded(this._user, this.nombre);
  UserModel get getUser => _user;
  @override
  List<Object> get props => [_user, nombre];
}

class UserIsNotLoaded extends UserState {}
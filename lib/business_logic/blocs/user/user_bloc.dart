import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;
  UserBloc({required this.userRepo}) : super(UserIsNotSearched()) {
    on<UserEvent>((event, emit) async {
      if (event is FechUser) {
        emit(UserIsLoading());
        try {
          final user = await userRepo.getUser(event.nombre);
          emit(UserIsLoaded(user, event.nombre));
        } catch (_) {
          emit(UserIsNotLoaded());
        }
      } else if (event is ResetUser) {
        emit(UserIsNotSearched());
      }
    });
  }
}
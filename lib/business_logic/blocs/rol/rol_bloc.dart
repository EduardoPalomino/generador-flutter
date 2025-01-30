import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/rol.dart';
import '../../data/repositories/rol_repository.dart';
part 'rol_event.dart';
part 'rol_state.dart';

class RolBloc extends Bloc<RolEvent, RolState> {
  final RolRepo rolRepo;
  RolBloc({required this.rolRepo}) : super(RolIsNotSearched()) {
    on<RolEvent>((event, emit) async {
      if (event is FechRol) {
        emit(RolIsLoading());
        try {
          final rol = await rolRepo.getRol(event.nombre);
          emit(RolIsLoaded(rol, event.nombre));
        } catch (_) {
          emit(RolIsNotLoaded());
        }
      } else if (event is ResetRol) {
        emit(RolIsNotSearched());
      }
    });
  }
}
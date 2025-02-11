import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/rol.dart';
import '../../../data/repositories/rol_repository.dart';

part 'rol_event.dart';
part 'rol_state.dart';

class RolBloc extends Bloc<RolEvent, RolState> {
  final RolRepository rolRepository;

  RolBloc(this.rolRepository) : super(RolInitialState()) {
    on<LoadRolEvent>(_onLoadRol);
    on<AddRolEvent>(_onAddRol);
    on<UpdateRolEvent>(_onUpdateRol);
    on<DeleteRolEvent>(_onDeleteRol);
  }

  Future<void> _onLoadRol(LoadRolEvent event, Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      final items = await rolRepository.getRols();
      emit(RolSuccessState(items));
    } catch (e) {
      emit(RolErrorState(e.toString()));
    }
  }

  Future<void> _onAddRol(AddRolEvent event, Emitter<RolState> emit) async {
    try {
      await rolRepository.addRol(event.nombre, event.descripcion);
      await _reloadRols(emit);
    } catch (e) {
      emit(RolErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateRol(UpdateRolEvent event, Emitter<RolState> emit) async {
    try {
      await rolRepository.updateRol(event.id, event.nombre, event.descripcion);
      await _reloadRols(emit);
    } catch (e) {
      print('_onUpdateRol: ${e}');
      emit(RolErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteRol(DeleteRolEvent event, Emitter<RolState> emit) async {
    try {
      await rolRepository.deleteRol(event.id);
      await _reloadRols(emit);
    } catch (e) {
      emit(RolErrorState(e.toString()));
    }
  }

  Future<void> _reloadRols(Emitter<RolState> emit) async {
    emit(RolLoadingState());
    try {
      final items = await rolRepository.getRols();
      emit(RolSuccessState(items));
    } catch (e) {
      emit(RolErrorState(e.toString()));
    }
  }
}
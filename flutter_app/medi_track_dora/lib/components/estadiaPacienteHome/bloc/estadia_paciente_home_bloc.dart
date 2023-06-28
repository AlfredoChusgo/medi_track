import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medi_track_dora/components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'package:medi_track_dora/models/estadia_paciente_filter_model.dart';

import '../../../models/estadia_paciente_model.dart';
import '../../../repositories/estadia_paciente_repository.dart';

part 'estadia_paciente_home_event.dart';
part 'estadia_paciente_home_state.dart';

class EstadiaPacienteHomeBloc
    extends Bloc<EstadiaPacienteHomeEvent, EstadiaPacienteHomeState> {
  final EstadiaPacienteRepository _repository;
  EstadiaPacienteHomeBloc({required EstadiaPacienteRepository repository})
      : _repository = repository,
        super(EstadiaPacienteHomeLoadingState()) {
    on<EstadiaPacienteHomeRefreshEvent>(_onEstadiaPacienteHomeRefreshEvent);
    on<EstadiaPacienteHomeRefreshWithFiltersEvent>(
        _onEstadiaPacienteHomeRefreshWithFiltersEvent);
    on<DeleteEstadiaPacienteEvent>(_onDeleteEstadiaPacienteEvent);
  }

  Future<void> _onEstadiaPacienteHomeRefreshEvent(
      EstadiaPacienteHomeRefreshEvent event,
      Emitter<EstadiaPacienteHomeState> emit) async {
    try {
      emit(EstadiaPacienteHomeLoadingState());
      List<EstadiaPaciente> result = await _repository.getEstadiaPacientes();
      if (result.isEmpty) {
        emit(EstadiaPacienteEmptyListState());
      } else {
        emit(EstadiaPacienteHomeLoadedState(estadiaPacientes: result));
      }
    } catch (e) {
      emit(EstadiaPacienteHomeErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onEstadiaPacienteHomeRefreshWithFiltersEvent(
      EstadiaPacienteHomeRefreshWithFiltersEvent event,
      Emitter<EstadiaPacienteHomeState> emit) async {
    try {
      emit(EstadiaPacienteHomeLoadingState());
      emit(EstadiaPacienteHomeLoadedState(
          estadiaPacientes:
              await _repository.getEstadiaPacientesWithFilter(event.filter)));
    } catch (e) {
      emit(EstadiaPacienteHomeErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onDeleteEstadiaPacienteEvent(DeleteEstadiaPacienteEvent event,
      Emitter<EstadiaPacienteHomeState> emit) async {
    emit(EstadiaPacienteHomeLoadingState());
    await _repository.deleteEstadiaPaciente(event.id);
    try {
      emit(EstadiaPacienteHomeLoadingState());
      List<EstadiaPaciente> result = await _repository.getEstadiaPacientes();
      if (result.isEmpty) {
        emit(EstadiaPacienteEmptyListState());
      } else {
        emit(EstadiaPacienteHomeLoadedState(estadiaPacientes: result));
      }
    } catch (e) {
      emit(EstadiaPacienteHomeErrorState(errorMessage: e.toString()));
    }
  }
}

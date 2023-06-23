import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medi_track_dora/components/pacienteHome/paciente_repository.dart';
import 'package:meta/meta.dart';

import '../paciente.dart';

part 'paciente_home_event.dart';
part 'paciente_home_state.dart';

class PacienteHomeBloc extends Bloc<PacienteHomeEvent, PacienteHomeState> {
  final PacienteRepository _pacienteRepository;

  PacienteHomeBloc({required PacienteRepository pacienteRepository})
   : _pacienteRepository = pacienteRepository,
   super(PacienteHomeLoadingState()) {
    on<PacienteHomeRefreshEvent>(_onPacienteHomeRefreshEvent);
    on<PacienteHomeRefreshWithFilterEvent>(_onPacienteHomeRefreshWithFilterEvent);
  }

  Future<void> _onPacienteHomeRefreshEvent(PacienteHomeRefreshEvent event, Emitter<PacienteHomeState> emit) async {
    try {
      emit(PacienteHomeLoadingState());
      List<Paciente> result = await _pacienteRepository.getPacientes();
      if(result.isEmpty){
        emit(PacienteHomeEmptyList());
      }else{
        emit(PacienteHomeLoadedState(pacientes: result));
      }
    } catch (e) {
      emit(PacienteHomeErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onPacienteHomeRefreshWithFilterEvent(PacienteHomeRefreshWithFilterEvent event, Emitter<PacienteHomeState> emit) async {
    try {
      emit(PacienteHomeLoadingState());
      List<Paciente> result = await _pacienteRepository.getPacientesFiltered(event.name);
      if(result.isEmpty){
        emit(PacienteHomeEmptyList());
      }else{
        emit(PacienteHomeLoadedState(pacientes: result));
      }
      
    } catch (e) {
      emit(PacienteHomeErrorState(errorMessage: e.toString()));
    }
  }
}

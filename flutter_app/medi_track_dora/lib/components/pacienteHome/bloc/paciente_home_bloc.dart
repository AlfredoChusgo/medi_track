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
    on<PacienteHomeAddEvent>(_onPacienteHomeAddEvent);
    on<PacienteHomeEditEvent>(_onPacienteHomeEditEvent);
    on<PacienteHomeDeleteEvent>(_onPacienteHomeDeleteEvent);
  }

  Future<void> _onPacienteHomeRefreshEvent(PacienteHomeRefreshEvent event, Emitter<PacienteHomeState> emit) async {
    try {
      emit(PacienteHomeLoadingState());
      emit(PacienteHomeLoadedState(pacientes: await _pacienteRepository.getPacientes()));
    } catch (e) {
      emit(PacienteHomeErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> _onPacienteHomeAddEvent(PacienteHomeAddEvent event, Emitter<PacienteHomeState> emit) async {

  }
  Future<void> _onPacienteHomeEditEvent(PacienteHomeEditEvent event, Emitter<PacienteHomeState> emit) async {

  }
  Future<void> _onPacienteHomeDeleteEvent(PacienteHomeDeleteEvent event, Emitter<PacienteHomeState> emit) async {

  }
}

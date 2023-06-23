import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/estadia_paciente.dart';
import '../../../repositories/estadia_paciente_repository.dart';

part 'estadia_paciente_home_event.dart';
part 'estadia_paciente_home_state.dart';

class EstadiaPacienteHomeBloc extends Bloc<EstadiaPacienteHomeEvent, EstadiaPacienteHomeState> {
  final EstadiaPacienteRepository _repository;
  EstadiaPacienteHomeBloc({required EstadiaPacienteRepository repository}) :  
  _repository = repository,
  super(EstadiaPacienteHomeLoadingState()) {
    on<EstadiaPacienteHomeRefreshEvent>(_onEstadiaPacienteHomeRefreshEvent);
  }

    Future<void> _onEstadiaPacienteHomeRefreshEvent(EstadiaPacienteHomeRefreshEvent event, Emitter<EstadiaPacienteHomeState> emit) async {
    try {
      emit(EstadiaPacienteHomeLoadingState());
      emit(EstadiaPacienteHomeLoadedState(estadiaPacientes: await _repository.getEstadiaPacientes()));
    } catch (e) {
      emit(EstadiaPacienteHomeErrorState(errorMessage: e.toString()));
    }
  }
}

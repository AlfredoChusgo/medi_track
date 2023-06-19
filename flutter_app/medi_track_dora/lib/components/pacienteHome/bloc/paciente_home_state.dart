part of 'paciente_home_bloc.dart';

sealed class PacienteHomeState  extends Equatable {

@override
  List<Object> get props => [];
}

class PacienteHomeLoadingState  extends PacienteHomeState {

@override
  List<Object> get props => [];
}

class PacienteHomeLoadedState  extends PacienteHomeState {
PacienteHomeLoadedState({required this.pacientes});
final List<Paciente> pacientes;
@override
  List<Object> get props => [pacientes];
}

class PacienteHomeErrorState  extends PacienteHomeState {
PacienteHomeErrorState({this.errorMessage = "Something happen"});
final String errorMessage;
@override
  List<Object> get props => [];
}
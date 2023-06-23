part of 'estadia_paciente_home_bloc.dart';


sealed class EstadiaPacienteHomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class EstadiaPacienteHomeLoadingState extends EstadiaPacienteHomeState {
  @override
  List<Object> get props => [];
}

class EstadiaPacienteHomeLoadedState extends EstadiaPacienteHomeState {
  EstadiaPacienteHomeLoadedState({required this.estadiaPacientes});
  final List<EstadiaPaciente> estadiaPacientes;
  @override
  List<Object> get props => [estadiaPacientes];
}

class EstadiaPacienteHomeErrorState extends EstadiaPacienteHomeState {
  EstadiaPacienteHomeErrorState({this.errorMessage = "Algo paso ! "});
  final String errorMessage;
  @override
  List<Object> get props => [];
}

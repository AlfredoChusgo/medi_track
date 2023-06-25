part of 'estadia_paciente_home_bloc.dart';


sealed class EstadiaPacienteHomeEvent extends Equatable{}

final class EstadiaPacienteHomeRefreshEvent extends EstadiaPacienteHomeEvent {
  
  @override  
  List<Object?> get props => [];
}
class EstadiaPacienteHomeRefreshWithFiltersEvent extends EstadiaPacienteHomeEvent {
  final EstadiaPacienteFilter filter;
  EstadiaPacienteHomeRefreshWithFiltersEvent({required this.filter});
  
  @override  
  List<Object?> get props => [];  
}

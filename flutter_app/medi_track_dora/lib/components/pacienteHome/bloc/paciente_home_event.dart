part of 'paciente_home_bloc.dart';

sealed class PacienteHomeEvent extends Equatable{
  const PacienteHomeEvent();
}

final class PacienteHomeRefreshEvent extends PacienteHomeEvent {
  @override  
  List<Object?> get props => [];
}

final class PacienteHomeRefreshWithFilterEvent extends PacienteHomeEvent {
  final String name;
  const PacienteHomeRefreshWithFilterEvent({required this.name});

  @override  
  List<Object?> get props => [];
}

part of 'paciente_home_bloc.dart';

sealed class PacienteHomeEvent {
  const PacienteHomeEvent();
}

final class PacienteHomeRefreshEvent extends PacienteHomeEvent {}
final class PacienteHomeAddEvent extends PacienteHomeEvent {}
final class PacienteHomeEditEvent extends PacienteHomeEvent {}
final class PacienteHomeDeleteEvent extends PacienteHomeEvent {}


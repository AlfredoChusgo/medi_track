part of 'paciente_home_bloc.dart';

sealed class PacienteHomeEvent {
  const PacienteHomeEvent();
}

final class PacienteHomeRefreshEvent extends PacienteHomeEvent {}

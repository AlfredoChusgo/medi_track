part of 'estadia_paciente_form_bloc.dart';

sealed class EstadiaPacienteFormEvent extends Equatable {}

class ReadEstadiaPacienteFormEvent extends EstadiaPacienteFormEvent {
  final EstadiaPaciente estadiaPaciente;
  ReadEstadiaPacienteFormEvent({required this.estadiaPaciente});

  @override
  List<Object?> get props => [estadiaPaciente];
}

class EditEstadiaPacienteFormEvent extends EstadiaPacienteFormEvent {
  final EstadiaPaciente estadiaPaciente;
  EditEstadiaPacienteFormEvent({required this.estadiaPaciente});

  @override
  List<Object?> get props => [estadiaPaciente];
}

class NewEstadiaPacienteFormEvent extends EstadiaPacienteFormEvent {
  final Paciente paciente;
  NewEstadiaPacienteFormEvent({required this.paciente});

  @override
  List<Object?> get props => [paciente];
}

class SaveEstadiaPacienteFormEvent extends EstadiaPacienteFormEvent {
  final EstadiaPaciente estadiaPaciente;
  SaveEstadiaPacienteFormEvent({required this.estadiaPaciente});
  @override
  List<Object?> get props => [estadiaPaciente];
}

class UpdateEstadiaPacienteFormEvent extends EstadiaPacienteFormEvent {
  final EstadiaPaciente estadiaPaciente;
  UpdateEstadiaPacienteFormEvent({required this.estadiaPaciente});
  @override
  List<Object?> get props => [estadiaPaciente];
}


class DeleteEstadiaPacienteFormEvent extends EstadiaPacienteFormEvent {
  final String id;
  DeleteEstadiaPacienteFormEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

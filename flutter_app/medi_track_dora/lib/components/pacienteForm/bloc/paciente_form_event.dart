part of 'paciente_form_bloc.dart';

@immutable
sealed class PacienteFormEvent extends Equatable {
  const PacienteFormEvent();

  @override
  List<Object> get props => [];
}

class PacienteAddNewEvent extends PacienteFormEvent {
  const PacienteAddNewEvent();

  @override
  List<Object> get props => [];
}

class PacienteDetailsInReadOnlyEvent extends PacienteFormEvent {
  final Paciente paciente;
  const PacienteDetailsInReadOnlyEvent({required this.paciente});

  @override
  List<Object> get props => [paciente];
}

class PacienteEditEvent extends PacienteFormEvent {
  final Paciente paciente;

  const PacienteEditEvent(this.paciente);

  @override
  List<Object> get props => [paciente];
}

class CIChanged extends PacienteFormEvent {
  final String ci;

  const CIChanged(this.ci);

  @override
  List<Object> get props => [ci];
}

class NombreChanged extends PacienteFormEvent {
  final String nombre;

  const NombreChanged(this.nombre);

  @override
  List<Object> get props => [nombre];
}

class ApellidoPaternoChanged extends PacienteFormEvent {
  final String apellidoPaterno;

  const ApellidoPaternoChanged(this.apellidoPaterno);

  @override
  List<Object> get props => [apellidoPaterno];
}

class ApellidoMaternoChanged extends PacienteFormEvent {
  final String apellidoMaterno;

  const ApellidoMaternoChanged(this.apellidoMaterno);

  @override
  List<Object> get props => [apellidoMaterno];
}

class FechaNacimientoChanged extends PacienteFormEvent {
  final DateTime fechaNacimiento;

  const FechaNacimientoChanged(this.fechaNacimiento);

  @override
  List<Object> get props => [fechaNacimiento];
}

class SexoChanged extends PacienteFormEvent {
  final Sexo sexo;

  const SexoChanged(this.sexo);

  @override
  List<Object> get props => [sexo];
}

class OcupacionChanged extends PacienteFormEvent {
  final String ocupacion;

  const OcupacionChanged(this.ocupacion);

  @override
  List<Object> get props => [ocupacion];
}

class ProcedenciaChanged extends PacienteFormEvent {
  final String procedencia;

  const ProcedenciaChanged(this.procedencia);

  @override
  List<Object> get props => [procedencia];
}

class TelefonoCelularChanged extends PacienteFormEvent {
  final int telefonoCelular;

  const TelefonoCelularChanged(this.telefonoCelular);

  @override
  List<Object> get props => [telefonoCelular];
}

class TelefonoFijoChanged extends PacienteFormEvent {
  final int telefonoFijo;

  const TelefonoFijoChanged(this.telefonoFijo);

  @override
  List<Object> get props => [telefonoFijo];
}

class DireccionResidenciaChanged extends PacienteFormEvent {
  final String direccionResidencia;

  const DireccionResidenciaChanged(this.direccionResidencia);

  @override
  List<Object> get props => [direccionResidencia];
}

class ContactoEmergenciaAdded extends PacienteFormEvent {
  final ContactoEmergencia contactoEmergencia;

  const ContactoEmergenciaAdded(this.contactoEmergencia);

  @override
  List<Object> get props => [contactoEmergencia];
}

class ContactosEmergenciaUpdated extends PacienteFormEvent {
  final ContactoEmergencia contactoEmergencia;

  const ContactosEmergenciaUpdated(this.contactoEmergencia);

  @override
  List<Object> get props => [contactoEmergencia];
}

class ContactosEmergenciaDeleted extends PacienteFormEvent {
  final String id;

  const ContactosEmergenciaDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class PacientePerformSave extends PacienteFormEvent {
  const PacientePerformSave();

  @override
  List<Object> get props => [];
}

class PacientePerformUpdate extends PacienteFormEvent {
  const PacientePerformUpdate();

  @override
  List<Object> get props => [];
}

class PacientePerformDelete extends PacienteFormEvent {
  final String id;
  const PacientePerformDelete({required this.id});

  @override
  List<Object> get props => [id];
}

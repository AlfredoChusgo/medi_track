part of 'paciente_add_bloc.dart';

@immutable
sealed class PacienteAddEvent extends Equatable {
  const PacienteAddEvent();

  @override
  List<Object> get props => [];
}

class CIChanged extends PacienteAddEvent {
  final String ci;

  const CIChanged(this.ci);

  @override
  List<Object> get props => [ci];
}

class NombreChanged extends PacienteAddEvent {
  final String nombre;

  const NombreChanged(this.nombre);

  @override
  List<Object> get props => [nombre];
}

class ApellidoPaternoChanged extends PacienteAddEvent {
  final String apellidoPaterno;

  const ApellidoPaternoChanged(this.apellidoPaterno);

  @override
  List<Object> get props => [apellidoPaterno];
}

class ApellidoMaternoChanged extends PacienteAddEvent {
  final String apellidoMaterno;

  const ApellidoMaternoChanged(this.apellidoMaterno);

  @override
  List<Object> get props => [apellidoMaterno];
}

class FechaNacimientoChanged extends PacienteAddEvent {
  final DateTime fechaNacimiento;

  const FechaNacimientoChanged(this.fechaNacimiento);

  @override
  List<Object> get props => [fechaNacimiento];
}

class SexoChanged extends PacienteAddEvent {
  final Sexo sexo;

  const SexoChanged(this.sexo);

  @override
  List<Object> get props => [sexo];
}

class OcupacionChanged extends PacienteAddEvent {
  final String ocupacion;

  const OcupacionChanged(this.ocupacion);

  @override
  List<Object> get props => [ocupacion];
}

class ProcedenciaChanged extends PacienteAddEvent {
  final String procedencia;

  const ProcedenciaChanged(this.procedencia);

  @override
  List<Object> get props => [procedencia];
}

class TelefonoCelularChanged extends PacienteAddEvent {
  final int telefonoCelular;

  const TelefonoCelularChanged(this.telefonoCelular);

  @override
  List<Object> get props => [telefonoCelular];
}

class TelefonoFijoChanged extends PacienteAddEvent {
  final int telefonoFijo;

  const TelefonoFijoChanged(this.telefonoFijo);

  @override
  List<Object> get props => [telefonoFijo];
}

class DireccionResidenciaChanged extends PacienteAddEvent {
  final String direccionResidencia;

  const DireccionResidenciaChanged(this.direccionResidencia);

  @override
  List<Object> get props => [direccionResidencia];
}

class ContactoEmergenciaAdded extends PacienteAddEvent {
  final ContactoEmergencia contactoEmergencia;

  const ContactoEmergenciaAdded(this.contactoEmergencia);

  @override
  List<Object> get props => [contactoEmergencia];
}

class ContactosEmergenciaUpdated extends PacienteAddEvent {
  final ContactoEmergencia contactoEmergencia;

  const ContactosEmergenciaUpdated(this.contactoEmergencia);

  @override
  List<Object> get props => [contactoEmergencia];
}

class ContactosEmergenciaDeleted extends PacienteAddEvent {
  final String id;

  const ContactosEmergenciaDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class PacienteSubmit extends PacienteAddEvent {
  const PacienteSubmit();

  @override
  List<Object> get props => [];
}
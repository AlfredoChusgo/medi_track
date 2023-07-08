part of 'paciente_form_bloc.dart';

sealed class PacienteFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class PacienteAddFormState extends PacienteFormState {
  final String id;
  final String ci;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final DateTime fechaNacimiento;
  final Sexo sexo;
  final String ocupacion;
  final String procedencia;
  final int telefonoCelular;
  final int telefonoFijo;
  final String direccionResidencia;
  final List<ContactoEmergencia> contactosEmergencia;
  final DateTime createdAt;
  final int numeroHistoriaClinica;

  final bool readOnly;

  PacienteAddFormState(
      {required this.id,
      required this.ci,
      required this.nombre,
      required this.apellidoPaterno,
      required this.apellidoMaterno,
      required this.fechaNacimiento,
      required this.sexo,
      required this.ocupacion,
      required this.procedencia,
      required this.telefonoCelular,
      required this.telefonoFijo,
      required this.direccionResidencia,
      required this.contactosEmergencia,
      required this.readOnly,
      required this.createdAt,
      required this.numeroHistoriaClinica
      });

  PacienteAddFormState.initial()
      : id = '',
        ci = '',
        nombre = '',
        apellidoPaterno = '',
        apellidoMaterno = '',
        fechaNacimiento = DateTime(2000, 1, 1), // Example default date
        sexo = Sexo.masculino, // Example default enum value
        ocupacion = '',
        procedencia = '',
        telefonoCelular = 0,
        telefonoFijo = 0,
        direccionResidencia = '',
        contactosEmergencia = [],
        readOnly = false,
        createdAt = DateTime.now(),
        numeroHistoriaClinica = 0;

  PacienteAddFormState copyWith({
    String? id,
    String? ci,
    String? nombre,
    String? apellidoPaterno,
    String? apellidoMaterno,
    DateTime? fechaNacimiento,
    Sexo? sexo,
    String? ocupacion,
    String? procedencia,
    int? telefonoCelular,
    int? telefonoFijo,
    String? direccionResidencia,
    List<ContactoEmergencia>? contactosEmergencia,
    bool? readOnly,
    DateTime? createdAt,
    int? numeroHistoriaClinica
  }) {
    return PacienteAddFormState(
      id: id ?? this.id,
      ci: ci ?? this.ci,
      nombre: nombre ?? this.nombre,
      apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
      apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      sexo: sexo ?? this.sexo,
      ocupacion: ocupacion ?? this.ocupacion,
      procedencia: procedencia ?? this.procedencia,
      telefonoCelular: telefonoCelular ?? this.telefonoCelular,
      telefonoFijo: telefonoFijo ?? this.telefonoFijo,
      direccionResidencia: direccionResidencia ?? this.direccionResidencia,
      contactosEmergencia: contactosEmergencia ?? this.contactosEmergencia,
      readOnly : readOnly ?? this.readOnly,
      createdAt: createdAt ?? this.createdAt,
      numeroHistoriaClinica: numeroHistoriaClinica?? this.numeroHistoriaClinica
    );
  }

  factory PacienteAddFormState.copyWith({required Paciente paciente}) {
    return PacienteAddFormState(
      id: paciente.id,
      ci: paciente.ci ,
      nombre: paciente.nombre ,
      apellidoPaterno: paciente.apellidoPaterno ,
      apellidoMaterno: paciente.apellidoMaterno ,
      fechaNacimiento: paciente.fechaNacimiento ,
      sexo: paciente.sexo ,
      ocupacion: paciente.ocupacion,
      procedencia: paciente.procedencia,
      telefonoCelular: paciente.telefonoCelular,
      telefonoFijo: paciente.telefonoFijo,
      direccionResidencia: paciente.direccionResidencia,
      contactosEmergencia: paciente.contactosEmergencia,
      readOnly : false,
      createdAt: paciente.createdAt,
      numeroHistoriaClinica : paciente.numeroHistoriaClinica
    );
  }

  Paciente toPaciente(){
    return Paciente(
      id: id.isEmpty ? const Uuid().v4() : id,
      ci: ci,
      nombre: nombre,
      apellidoPaterno: apellidoPaterno,
      apellidoMaterno: apellidoMaterno,
      fechaNacimiento: fechaNacimiento,
      sexo: sexo,
      ocupacion: ocupacion,
      procedencia: procedencia,
      telefonoCelular: telefonoCelular,
      telefonoFijo: telefonoFijo,
      direccionResidencia: direccionResidencia,
      contactosEmergencia: contactosEmergencia,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      numeroHistoriaClinica : numeroHistoriaClinica
    );
  }

  @override
  List<Object> get props => [
        id,
        ci,
        nombre,
        apellidoMaterno,
        apellidoPaterno,
        fechaNacimiento,
        sexo,
        ocupacion,
        procedencia,
        telefonoCelular,
        telefonoFijo,
        direccionResidencia,
        contactosEmergencia,
        readOnly,
        createdAt,
        numeroHistoriaClinica
      ];
}

class SavingInProgress extends PacienteFormState {}


class PacienteActionResponse extends PacienteFormState {
  final String message;
  final bool isError;
  final bool shouldPop;
  final String id = const Uuid().v4();
  PacienteActionResponse({required this.message, required this.isError, required this.shouldPop});

  @override
  List<Object> get props => [message,isError,shouldPop,id];
}

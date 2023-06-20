part of 'paciente_add_bloc.dart';

sealed class PacienteAddState extends Equatable {
  @override
  List<Object> get props => [];
}

class PacienteAddFormState extends PacienteAddState {
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
      required this.direccionResidencia});

  PacienteAddFormState.Initial()
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
        direccionResidencia = '';

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
        direccionResidencia
      ];
}

class SavingInProgress extends PacienteAddState {}

class ErrorDuringSaved extends PacienteAddState {
  final String errorMessage;
  
  ErrorDuringSaved({required this.errorMessage});

  @override
  List<Object> get props => [];
}

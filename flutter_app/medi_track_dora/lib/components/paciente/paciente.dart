import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Sexo { masculino, femenino }

class Paciente extends Equatable {
  const Paciente(
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
      required this.contactoEmergencia});

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
  final List<ContactoEmergencia> contactoEmergencia;

  @override
  List<Object> get props => [
        id,
        ci,
        nombre,
        apellidoPaterno,
        apellidoMaterno,
        fechaNacimiento,
        sexo,
        ocupacion,
        procedencia,
        telefonoCelular,
        telefonoFijo,
        direccionResidencia,
        contactoEmergencia
      ];

  static final empty = Paciente(
      id: const Uuid().v4(),
      apellidoMaterno: '',
      apellidoPaterno: '',
      ci: '',
      contactoEmergencia: [],
      direccionResidencia: '',
      fechaNacimiento: DateTime.now(),      
      nombre: '',
      ocupacion: '',
      procedencia: '',
      sexo: Sexo.masculino,
      telefonoCelular: 0000000,
      telefonoFijo: 0000000);
}

class ContactoEmergencia extends Equatable {
  const ContactoEmergencia(
      {required this.id,
      required this.relacionFamiliar,
      required this.nombre,
      required this.apellidoMaterno,
      required this.apellidoPaterno,
      required this.telefono,
      required this.direccion});

  final String id;
  final String relacionFamiliar;
  final String nombre;
  final String apellidoMaterno;
  final String apellidoPaterno;
  final int telefono;
  final String direccion;

  @override
  List<Object> get props => [
        relacionFamiliar,
        nombre,
        apellidoMaterno,
        apellidoPaterno,
        telefono,
        direccion
      ];

  static const empty = ContactoEmergencia(
      apellidoMaterno: '',
      apellidoPaterno: '',
      direccion: '',
      id: '',
      nombre: '',
      relacionFamiliar: '',
      telefono: 0000000);
}

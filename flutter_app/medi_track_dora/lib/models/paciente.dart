import 'dart:convert';

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
      required this.contactosEmergencia,
      required this.createdAt,
      required this.updatedAt,
      required this.numeroHistoriaClinica});

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
  final DateTime updatedAt;
  final int numeroHistoriaClinica;

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
        contactosEmergencia,
        createdAt,
        updatedAt,
        numeroHistoriaClinica
      ];

  String get fullName {
    return "$nombre $apellidoPaterno $apellidoMaterno";
  }

  factory Paciente.empty() {
    return Paciente(
        id: const Uuid().v4(),
        apellidoMaterno: '',
        apellidoPaterno: '',
        ci: '',
        contactosEmergencia: const [],
        direccionResidencia: '',
        fechaNacimiento: DateTime.now(),
        nombre: '',
        ocupacion: '',
        procedencia: '',
        sexo: Sexo.masculino,
        telefonoCelular: 0000000,
        telefonoFijo: 0000000,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        numeroHistoriaClinica: 0);
  }

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
        id: json['id'],
        ci: json['ci'],
        nombre: json['nombre'],
        apellidoPaterno: json['apellidoPaterno'],
        apellidoMaterno: json['apellidoMaterno'],
        fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
        sexo: json['sexo'] == 'masculino' ? Sexo.masculino : Sexo.femenino,
        ocupacion: json['ocupacion'],
        procedencia: json['procedencia'],
        telefonoCelular: json['telefonoCelular'],
        telefonoFijo: json['telefonoFijo'],
        direccionResidencia: json['direccionResidencia'],
        contactosEmergencia: (json['contactosEmergencia'] as List<dynamic>)
            .map((contactoJson) => ContactoEmergencia.fromJson(contactoJson))
            .toList(),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        numeroHistoriaClinica: json['numeroHistoriaClinica']);
  }

  Paciente copyWith(
      {String? id,
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
      DateTime? createdAt,
      DateTime? updatedAt,
      int? numeroHistoriaClinica}) {
    return Paciente(
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
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        numeroHistoriaClinica:
            numeroHistoriaClinica ?? this.numeroHistoriaClinica);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ci': ci,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'fechaNacimiento': fechaNacimiento.millisecondsSinceEpoch,
      'sexo': sexo.toString().split('.').last,
      'ocupacion': ocupacion,
      'procedencia': procedencia,
      'telefonoCelular': telefonoCelular,
      'telefonoFijo': telefonoFijo,
      'direccionResidencia': direccionResidencia,
      'contactosEmergencia': jsonEncode(contactosEmergencia),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'numeroHistoriaClinica': numeroHistoriaClinica,
    };
  }

  static Paciente fromMap(Map<String, dynamic> map) {
    return Paciente(
        id: map['id'],
        ci: map['ci'],
        nombre: map['nombre'],
        apellidoPaterno: map['apellidoPaterno'],
        apellidoMaterno: map['apellidoMaterno'],
        fechaNacimiento:
            DateTime.fromMillisecondsSinceEpoch(map['fechaNacimiento']),
        sexo: Sexo.values.firstWhere(
            (value) => value.toString().split('.').last == map['sexo']),
        ocupacion: map['ocupacion'],
        procedencia: map['procedencia'],
        telefonoCelular: map['telefonoCelular'],
        telefonoFijo: map['telefonoFijo'],
        direccionResidencia: map['direccionResidencia'],
        contactosEmergencia:
            (jsonDecode(map['contactosEmergencia']) as List<dynamic>)
                .map((e) => ContactoEmergencia.fromMap(e))
                .toList(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
        numeroHistoriaClinica: map['numeroHistoriaClinica']);
  }

  static List<Paciente> sortByUpdatedAt(List<Paciente> pacientes) {
    return pacientes..sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ci': ci,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'sexo': sexo.index,
      'ocupacion': ocupacion,
      'procedencia': procedencia,
      'telefonoCelular': telefonoCelular,
      'telefonoFijo': telefonoFijo,
      'direccionResidencia': direccionResidencia,
      'contactosEmergencia':
          //contactosEmergencia.map((e) => e.toJson()).toList(),
          jsonEncode(contactosEmergencia),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'numeroHistoriaClinica': numeroHistoriaClinica,
    };
  }

  // ...
}

class ContactoEmergencia extends Equatable {
  const ContactoEmergencia(
      {required this.id,
      required this.relacionFamiliar,
      required this.nombre,
      required this.apellidoMaterno,
      required this.apellidoPaterno,
      required this.telefono,
      required this.direccion,
      required this.isResponsable});

  final String id;
  final String relacionFamiliar;
  final String nombre;
  final String apellidoMaterno;
  final String apellidoPaterno;
  final int telefono;
  final String direccion;
  final bool isResponsable;

  @override
  List<Object> get props => [
        id,
        relacionFamiliar,
        nombre,
        apellidoMaterno,
        apellidoPaterno,
        telefono,
        direccion,
        isResponsable
      ];

  factory ContactoEmergencia.empty() {
    return ContactoEmergencia(
        id: const Uuid().v4(),
        apellidoMaterno: '',
        apellidoPaterno: '',
        direccion: '',
        nombre: '',
        relacionFamiliar: '',
        telefono: 0000000,
        isResponsable: false);
  }

  ContactoEmergencia copyWith(
      {String? id,
      String? relacionFamiliar,
      String? nombre,
      String? apellidoMaterno,
      String? apellidoPaterno,
      int? telefono,
      String? direccion,
      bool? isResponsable}) {
    return ContactoEmergencia(
        id: id ?? this.id,
        relacionFamiliar: relacionFamiliar ?? this.relacionFamiliar,
        nombre: nombre ?? this.nombre,
        apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
        apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
        telefono: telefono ?? this.telefono,
        direccion: direccion ?? this.direccion,
        isResponsable: isResponsable ?? this.isResponsable);
  }

  // Factory constructor to parse JSON data
  factory ContactoEmergencia.fromJson(Map<String, dynamic> json) {
    return ContactoEmergencia(
        id: json['id'],
        relacionFamiliar: json['relacionFamiliar'],
        nombre: json['nombre'],
        apellidoMaterno: json['apellidoMaterno'],
        apellidoPaterno: json['apellidoPaterno'],
        telefono: json['telefono'],
        direccion: json['direccion'],
        isResponsable: json['isResponsable']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'relacionFamiliar': relacionFamiliar,
      'nombre': nombre,
      'apellidoMaterno': apellidoMaterno,
      'apellidoPaterno': apellidoPaterno,
      'telefono': telefono,
      'direccion': direccion,
      'isResponsable': isResponsable
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'relacionFamiliar': relacionFamiliar,
      'nombre': nombre,
      'apellidoMaterno': apellidoMaterno,
      'apellidoPaterno': apellidoPaterno,
      'telefono': telefono,
      'direccion': direccion,
      'isResponsable': isResponsable
    };
  }

  static ContactoEmergencia fromMap(Map<String, dynamic> map) {
    return ContactoEmergencia(
        id: map['id'],
        relacionFamiliar: map['relacionFamiliar'],
        nombre: map['nombre'],
        apellidoMaterno: map['apellidoMaterno'],
        apellidoPaterno: map['apellidoPaterno'],
        telefono: map['telefono'],
        direccion: map['direccion'],
        isResponsable: map['isResponsable']);
  }
}

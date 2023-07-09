import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'paciente.dart';
import 'valueObjects/date_time_value_object.dart';

enum TipoServicio {
  desconocido,
  psicologia,
  nefrologia,
  medicinaInterna,
  consultaExterna
}

class EstadiaPaciente extends Equatable {
  const EstadiaPaciente(
      {required this.id,
      required this.paciente,
      required this.fechaIngreso,
      required this.fechaEgreso,
      required this.accionesRealizadas,
      required this.observaciones,
      required this.diagnostico,
      required this.tipoServicio,
      required this.createdAt,
      required this.updatedAt});

  final Paciente paciente;
  final String id;
  final DateTime fechaIngreso;
  final DateTimeValueObject fechaEgreso;
  final String accionesRealizadas;
  final String observaciones;
  final String diagnostico;
  final TipoServicio tipoServicio;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get tipoServicioReadable {
    return tipoServicio.toString().split('.').last;
  }

  @override
  List<Object> get props => [
        id,
        fechaIngreso,
        fechaEgreso,
        accionesRealizadas,
        observaciones,
        diagnostico,
        tipoServicio,
        createdAt,
        updatedAt
      ];

  factory EstadiaPaciente.empty() {
    return EstadiaPaciente(
        id: const Uuid().v4(),
        fechaIngreso: DateTime.now(),
        fechaEgreso: DateTimeValueObject.empty(),
        accionesRealizadas: '',
        observaciones: '',
        diagnostico: '',
        tipoServicio: TipoServicio.desconocido,
        paciente: Paciente.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }

  factory EstadiaPaciente.fromJson(Map<String, dynamic> json) {
    return EstadiaPaciente(
        id: json['id'],
        fechaIngreso: DateTime.parse(json['fechaIngreso']),
        fechaEgreso: DateTimeValueObject.fromJson(json['fechaEgreso']),
        accionesRealizadas: json['accionesRealizadas'],
        observaciones: json['observaciones'],
        diagnostico: json['diagnostico'],
        tipoServicio: TipoServicio.values[json['tipoServicio']],
        paciente: Paciente.empty().copyWith(id: json['idPaciente']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idPaciente': paciente.id,
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'fechaEgreso': fechaEgreso.toJson(),
      'accionesRealizadas': accionesRealizadas,
      'observaciones': observaciones,
      'diagnostico': diagnostico,
      'tipoServicio': tipoServicio.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }

  EstadiaPaciente copyWith(
      {String? id,
      Paciente? paciente,
      DateTime? fechaIngreso,
      DateTimeValueObject? fechaEgreso,
      String? accionesRealizadas,
      String? observaciones,
      String? diagnostico,
      TipoServicio? tipoServicio,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return EstadiaPaciente(
      id: id ?? this.id,
      paciente: paciente ?? this.paciente,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      fechaEgreso: fechaEgreso ?? this.fechaEgreso,
      accionesRealizadas: accionesRealizadas ?? this.accionesRealizadas,
      observaciones: observaciones ?? this.observaciones,
      diagnostico: diagnostico ?? this.diagnostico,
      tipoServicio: tipoServicio ?? this.tipoServicio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: createdAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pacienteId': paciente.id,
      //'paciente': paciente.toMap(), // Convert paciente to a map
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'fechaEgreso': fechaEgreso.toJson(),
      'accionesRealizadas': accionesRealizadas,
      'observaciones': observaciones,
      'diagnostico': diagnostico,
      'tipoServicio': tipoServicio.name, // Convert tipoServicio to a string
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }

  static EstadiaPaciente fromMap(Map<String, dynamic> map) {
    return EstadiaPaciente(
        id: map['id'],
        //paciente: Paciente.fromMap(map['paciente']), // Convert paciente from map
        paciente: Paciente.empty().copyWith(id: map['pacienteId']),
        fechaIngreso: DateTime.parse(map['fechaIngreso']),
        fechaEgreso: DateTimeValueObject.fromJson(map['fechaEgreso']),
        accionesRealizadas: map['accionesRealizadas'],
        observaciones: map['observaciones'],
        diagnostico: map['diagnostico'],
        tipoServicio: TipoServicio.values.firstWhere(
            (value) => value.toString().split('.').last == map['tipoServicio']),
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  static List<EstadiaPaciente> sortByUpdatedAt(
      List<EstadiaPaciente> estadias) {
    return estadias..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
}

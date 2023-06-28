import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'paciente.dart';

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
      required this.tipoServicio});

  final Paciente paciente;
  final String id;
  final DateTime fechaIngreso;
  final DateTime fechaEgreso;
  final String accionesRealizadas;
  final String observaciones;
  final String diagnostico;
  final TipoServicio tipoServicio;

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
        tipoServicio
      ];

  factory EstadiaPaciente.empty() {
    return EstadiaPaciente(
        id: const Uuid().v4(),
        fechaIngreso: DateTime.now(),
        fechaEgreso: DateTime.now().add(const Duration(days: 7)),
        accionesRealizadas: '',
        observaciones: '',
        diagnostico: '',
        tipoServicio: TipoServicio.desconocido, paciente: Paciente.empty());
  }

   factory EstadiaPaciente.fromJson(Map<String, dynamic> json) {
    return EstadiaPaciente(
      id: json['id'],
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
      fechaEgreso: DateTime.parse(json['fechaEgreso']),
      accionesRealizadas: json['accionesRealizadas'],
      observaciones: json['observaciones'],
      diagnostico: json['diagnostico'],
      tipoServicio: TipoServicio.values[json['tipoServicio']], 
      paciente: Paciente.empty().copyWith(id:json['idPaciente']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'fechaEgreso': fechaEgreso.toIso8601String(),
      'accionesRealizadas': accionesRealizadas,
      'observaciones': observaciones,
      'diagnostico': diagnostico,
      'tipoServicio': tipoServicio.index,
    };
  }

  EstadiaPaciente copyWith({
    String? id,
    Paciente? paciente,
    DateTime? fechaIngreso,
    DateTime? fechaEgreso,
    String? accionesRealizadas,
    String? observaciones,
    String? diagnostico,
    TipoServicio? tipoServicio,
  }) {
    return EstadiaPaciente(
      id: id ?? this.id,
      paciente: paciente ?? this.paciente,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      fechaEgreso: fechaEgreso ?? this.fechaEgreso,
      accionesRealizadas: accionesRealizadas ?? this.accionesRealizadas,
      observaciones: observaciones ?? this.observaciones,
      diagnostico: diagnostico ?? this.diagnostico,
      tipoServicio: tipoServicio ?? this.tipoServicio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pacienteId': paciente.id,
      //'paciente': paciente.toMap(), // Convert paciente to a map
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'fechaEgreso': fechaEgreso.toIso8601String(),
      'accionesRealizadas': accionesRealizadas,
      'observaciones': observaciones,
      'diagnostico': diagnostico,
      'tipoServicio': tipoServicio.name, // Convert tipoServicio to a string
    };
  }

  static EstadiaPaciente fromMap(Map<String, dynamic> map) {
    return EstadiaPaciente(
      id: map['id'],
      //paciente: Paciente.fromMap(map['paciente']), // Convert paciente from map
      paciente: Paciente.empty().copyWith(id:map['pacienteId']),
      fechaIngreso: DateTime.parse(map['fechaIngreso']),
      fechaEgreso: DateTime.parse(map['fechaEgreso']),
      accionesRealizadas: map['accionesRealizadas'],
      observaciones: map['observaciones'],
      diagnostico: map['diagnostico'],
      tipoServicio : TipoServicio.values.firstWhere((value) => value.toString().split('.').last == map['tipoServicio']),      
    );
  }
}

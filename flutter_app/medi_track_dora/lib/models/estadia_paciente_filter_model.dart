
import 'package:equatable/equatable.dart';

import '../components/pacienteHome/paciente.dart';
import 'estadia_paciente_model.dart';

class EstadiaPacienteFilter extends Equatable {
  final String pacienteName;
  final Paciente paciente;
  final DateTime fechaIngresoInicio;
  final DateTime fechaIngresoFin;
  final TipoServicio tipoServicio;
  final bool pacienteFilterEnabled;
  final bool fechaFilterEnabled;
  final bool servicioFilterEnabled;

  const EstadiaPacienteFilter(
      {required this.pacienteName,
      required this.paciente,
      required this.fechaIngresoFin,
      required this.fechaIngresoInicio,
      required this.tipoServicio,
      required this.pacienteFilterEnabled,
      required this.fechaFilterEnabled,
      required this.servicioFilterEnabled,
      });

  factory EstadiaPacienteFilter.empty() {
    return EstadiaPacienteFilter(
        pacienteName: "",
        paciente: Paciente.empty(),
        fechaIngresoFin: DateTime.now().add(const Duration(days: -20)),
        fechaIngresoInicio: DateTime.now(),
        tipoServicio: TipoServicio.desconocido,
        servicioFilterEnabled: false,
        pacienteFilterEnabled: false,
        fechaFilterEnabled: false);
  }

  EstadiaPacienteFilter copyWith({
    String? pacienteName,
    Paciente? paciente,
    DateTime? fechaIngresoInicio,
    DateTime? fechaIngresoFin,
    TipoServicio? tipoServicio,
    bool? pacienteFilterEnabled,
    bool? fechaFilterEnabled,
    bool? servicioFilterEnabled,

  }) {
    return EstadiaPacienteFilter(
      pacienteName: pacienteName ?? this.pacienteName,
      paciente: paciente ?? this.paciente,
      fechaIngresoInicio: fechaIngresoInicio ?? this.fechaIngresoInicio,
      fechaIngresoFin: fechaIngresoFin ?? this.fechaIngresoFin,
      tipoServicio: tipoServicio ?? this.tipoServicio,
      pacienteFilterEnabled: pacienteFilterEnabled ?? this.pacienteFilterEnabled,
      fechaFilterEnabled: fechaFilterEnabled ?? this.fechaFilterEnabled,
      servicioFilterEnabled: servicioFilterEnabled ?? this.servicioFilterEnabled,
    );
  }

  @override
  List<Object?> get props => [
        pacienteName,
        paciente,
        fechaIngresoInicio,
        fechaIngresoFin,
        tipoServicio
      ];
}
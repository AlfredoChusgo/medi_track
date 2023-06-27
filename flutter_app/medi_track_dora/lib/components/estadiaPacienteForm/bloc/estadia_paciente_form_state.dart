part of 'estadia_paciente_form_bloc.dart';

sealed class EstadiaPacienteFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EstadiaPacienteFormLoadingState extends EstadiaPacienteFormState {
}

class EstadiaPacienteFormDataState extends EstadiaPacienteFormState {
  final String id;
  final Paciente paciente;
  final DateTime fechaIngreso;
  final DateTime fechaEgreso;
  final String accionesRealizadas;
  final String observaciones;
  final String diagnostico;
  final TipoServicio tipoServicio;

  final bool readOnly;

  EstadiaPacienteFormDataState(
      {required this.id,
      required this.fechaIngreso,
      required this.fechaEgreso,
      required this.accionesRealizadas,
      required this.observaciones,
      required this.diagnostico,
      required this.tipoServicio,
      required this.paciente,
      required this.readOnly});

  factory EstadiaPacienteFormDataState.empty() {
    return EstadiaPacienteFormDataState(
        id: const Uuid().v4(),
        fechaIngreso: DateTime.now(),
        fechaEgreso: DateTime.now(),
        accionesRealizadas: '',
        observaciones: '',
        diagnostico: '',
        tipoServicio: TipoServicio.desconocido,
        paciente: Paciente.empty(),
        readOnly: false);
  }

  EstadiaPacienteFormDataState copyWith(
      {String? id,
      DateTime? fechaIngreso,
      DateTime? fechaEgreso,
      String? accionesRealizadas,
      String? observaciones,
      String? diagnostico,
      TipoServicio? tipoServicio,
      Paciente? paciente,
      bool? readOnly}) {
    return EstadiaPacienteFormDataState(
        id: id ?? this.id,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        fechaEgreso: fechaEgreso ?? this.fechaEgreso,
        accionesRealizadas: accionesRealizadas ?? this.accionesRealizadas,
        observaciones: observaciones ?? this.observaciones,
        diagnostico: diagnostico ?? this.diagnostico,
        tipoServicio: tipoServicio ?? this.tipoServicio,
        paciente: paciente ?? this.paciente,
        readOnly: readOnly ?? this.readOnly);
  }

  @override
  List<Object?> get props => [
        id,
        paciente,
        fechaIngreso,
        fechaEgreso,
        accionesRealizadas,
        observaciones,
        diagnostico,
        tipoServicio,
        readOnly
      ];
}

class EstadiaPacienteActionResponse extends EstadiaPacienteFormState {
  final String message;
  final bool isError;
  final bool shouldPop;
  EstadiaPacienteActionResponse(
      {required this.message, required this.isError, required this.shouldPop});

  @override
  List<Object> get props => [message, isError, shouldPop];
}

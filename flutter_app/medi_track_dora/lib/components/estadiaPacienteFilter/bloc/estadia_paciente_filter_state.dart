part of 'estadia_paciente_filter_bloc.dart';

class EstadiaPacienteFilterState extends Equatable {
  final String pacienteName;
  final Either<bool, Paciente> paciente;
  final Either<String, List<Paciente>> pacienteList;
  final DateTime fechaIngresoInicio;
  final DateTime fechaIngresoFin;
  final TipoServicio tipoServicio;
  final bool pacienteFilterEnabled;
  final bool fechaFilterEnabled;
  final bool servicioFilterEnabled;

  const EstadiaPacienteFilterState(
      {required this.pacienteName,
      required this.paciente,
      required this.pacienteList,
      required this.fechaIngresoFin,
      required this.fechaIngresoInicio,
      required this.tipoServicio,
      required this.pacienteFilterEnabled,
      required this.fechaFilterEnabled,
      required this.servicioFilterEnabled});

  factory EstadiaPacienteFilterState.empty() {
    return EstadiaPacienteFilterState(
        pacienteName: "",
        paciente: left(false),
        pacienteList: left("debe seleccionar un paciente"),
        fechaIngresoFin: DateTime.now().add(const Duration(days: -20)),
        fechaIngresoInicio: DateTime.now(),
        tipoServicio: TipoServicio.desconocido,
        pacienteFilterEnabled: false,
        fechaFilterEnabled: false,
        servicioFilterEnabled: false);
  }

  EstadiaPacienteFilterState copyWith({
    String? pacienteName,
    Either<bool, Paciente>? paciente,
    Either<String, List<Paciente>>? pacienteList,
    DateTime? fechaIngresoInicio,
    DateTime? fechaIngresoFin,
    TipoServicio? tipoServicio,
    bool? pacienteFilterEnabled,
    bool? fechaFilterEnabled,
    bool? servicioFilterEnabled,
  }) {
    return EstadiaPacienteFilterState(
        pacienteName: pacienteName ?? this.pacienteName,
        paciente: paciente ?? this.paciente,
        pacienteList: pacienteList ?? this.pacienteList,
        fechaIngresoInicio: fechaIngresoInicio ?? this.fechaIngresoInicio,
        fechaIngresoFin: fechaIngresoFin ?? this.fechaIngresoFin,
        tipoServicio: tipoServicio ?? this.tipoServicio,
        pacienteFilterEnabled:
            pacienteFilterEnabled ?? this.pacienteFilterEnabled,
        fechaFilterEnabled: fechaFilterEnabled ?? this.fechaFilterEnabled,
        servicioFilterEnabled:
            servicioFilterEnabled ?? this.servicioFilterEnabled);
  }

  EstadiaPacienteFilter toEstadiaPacienteFilter() {
    return EstadiaPacienteFilter(
        pacienteName: pacienteName,
        paciente: paciente.fold((l) => Paciente.empty(), (r) => r),
        fechaIngresoFin: fechaIngresoFin,
        fechaIngresoInicio: fechaIngresoInicio,
        tipoServicio: tipoServicio,
        pacienteFilterEnabled: pacienteFilterEnabled,
        fechaFilterEnabled: fechaFilterEnabled,
        servicioFilterEnabled: servicioFilterEnabled);
  }

  @override
  List<Object?> get props => [
        pacienteName,
        paciente,
        pacienteList,
        fechaIngresoInicio,
        fechaIngresoFin,
        tipoServicio,
        pacienteFilterEnabled,
        fechaFilterEnabled,
        servicioFilterEnabled,
      ];
}

//class EstadiaPacienteFilterInitial extends EstadiaPacienteFilterState {}

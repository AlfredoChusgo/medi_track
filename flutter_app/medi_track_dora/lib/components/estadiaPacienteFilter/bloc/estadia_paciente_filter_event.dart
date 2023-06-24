part of 'estadia_paciente_filter_bloc.dart';


sealed class EstadiaPacienteFilterEvent extends Equatable{}


class SearchPacienteByNameEvent extends EstadiaPacienteFilterEvent {

  final String name;

  SearchPacienteByNameEvent({required this.name});

  @override  
  List<Object?> get props => [name];
}

class SelectPacienteFromListevent extends EstadiaPacienteFilterEvent {

  final Paciente paciente;

  SelectPacienteFromListevent({required this.paciente});

  @override  
  List<Object?> get props => [paciente];
}

class SelectTipoServicioEvent extends EstadiaPacienteFilterEvent {

  final TipoServicio tipoServicio;

  SelectTipoServicioEvent({required this.tipoServicio});

  @override  
  List<Object?> get props => [tipoServicio];
}

class SelectFechaIngresoInicioEvent extends EstadiaPacienteFilterEvent {

  final DateTime fechaIngresoInicio;

  SelectFechaIngresoInicioEvent({required this.fechaIngresoInicio});

  @override  
  List<Object?> get props => [fechaIngresoInicio];
}

class SelectFechaIngresoFinEvent extends EstadiaPacienteFilterEvent {

  final DateTime fechaIngresoFin;

  SelectFechaIngresoFinEvent({required this.fechaIngresoFin});

  @override  
  List<Object?> get props => [fechaIngresoFin];
}

class UnSelectPacientetevent extends EstadiaPacienteFilterEvent {

  UnSelectPacientetevent();

  @override  
  List<Object?> get props => [];
}

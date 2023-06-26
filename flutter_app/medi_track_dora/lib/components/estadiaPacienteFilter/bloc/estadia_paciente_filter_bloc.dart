import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/estadia_paciente.dart';
import 'package:medi_track_dora/components/pacienteHome/paciente_repository.dart';
import 'package:medi_track_dora/models/estadia_paciente_filter_model.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import '../../pacienteHome/paciente.dart';
import 'package:dartz/dartz.dart';

part 'estadia_paciente_filter_event.dart';
part 'estadia_paciente_filter_state.dart';

class EstadiaPacienteFilterBloc
    extends Bloc<EstadiaPacienteFilterEvent, EstadiaPacienteFilterState> {
  final PacienteRepository pacienteRepository;
  EstadiaPacienteFilterBloc({required this.pacienteRepository})
      : super(EstadiaPacienteFilterState.empty()) {
    on<SearchPacienteByNameEvent>(_onSearchPacienteByNameEvent);
    on<SelectPacienteFromListevent>(_onSelectPacienteFromListevent);
    on<UnSelectPacientetevent>(_onUnSelectPacientetevent);
    on<SelectTipoServicioEvent>(_onSelectTipoServicioEvent);
    on<SelectFechaIngresoFinEvent>(_onSelectFechaIngresoFinEvent);
    on<SelectFechaIngresoInicioEvent>(_onSelectFechaIngresoInicioEvent);

    on<EnablePacienteFilterEvent>(_onEnablePacienteFilterEvent);
    on<DisablePacienteFilterEvent>(_onDisablePacienteFilterEvent);

    on<EnableFechaFilterEvent>(_onEnableFechaFilterEvent);
    on<DisableFechaFilterEvent>(_onDisableFechaFilterEvent);

    on<EnableServicioFilterEvent>(_onEnableServicioFilterEvent);
    on<DisableServicioFilterEvent>(_onDisableServicioFilterEvent);
  }

  FutureOr<void> _onSearchPacienteByNameEvent(SearchPacienteByNameEvent event,
      Emitter<EstadiaPacienteFilterState> emit) async {
    try {
      var list = await pacienteRepository.getPacientesFiltered(event.name);
      if (list.isNotEmpty) {
        emit(state.copyWith(
            pacienteName: event.name, pacienteList: Right(list)));
      } else {
        emit(state.copyWith(
            pacienteName: event.name,
            pacienteList: left("Sin Resultados ...")));
      }
    } catch (e) {
      emit(state.copyWith(
          pacienteName: event.name, pacienteList: left(e.toString())));
    }
  }

  FutureOr<void> _onSelectPacienteFromListevent(
      SelectPacienteFromListevent event,
      Emitter<EstadiaPacienteFilterState> emit) {
    emit(state.copyWith(
        paciente: right(event.paciente),
        pacienteName: "",
        pacienteList: right(const [])));
  }

  FutureOr<void> _onUnSelectPacientetevent(
      UnSelectPacientetevent event, Emitter<EstadiaPacienteFilterState> emit) {
    emit(state.copyWith(
        paciente: left(false),
        pacienteName: "",
        pacienteList: left("debe seleccionar un paciente")));
  }

  FutureOr<void> _onSelectTipoServicioEvent(
      SelectTipoServicioEvent event, Emitter<EstadiaPacienteFilterState> emit) {
    emit(state.copyWith(tipoServicio: event.tipoServicio));
  }

  FutureOr<void> _onSelectFechaIngresoFinEvent(SelectFechaIngresoFinEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
    emit(state.copyWith(fechaIngresoFin: event.fechaIngresoFin));
  }

  FutureOr<void> _onSelectFechaIngresoInicioEvent(
      SelectFechaIngresoInicioEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
    emit(state.copyWith(fechaIngresoInicio: event.fechaIngresoInicio));
  }

  FutureOr<void> _onEnablePacienteFilterEvent(EnablePacienteFilterEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
        emit(state.copyWith(pacienteFilterEnabled: true));
      }

  FutureOr<void> _onDisablePacienteFilterEvent(DisablePacienteFilterEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
        emit(state.copyWith(pacienteFilterEnabled: false));
      }

  FutureOr<void> _onEnableFechaFilterEvent(
      EnableFechaFilterEvent event, Emitter<EstadiaPacienteFilterState> emit) {
        emit(state.copyWith(fechaFilterEnabled: true));
      }

  FutureOr<void> _onDisableFechaFilterEvent(DisableFechaFilterEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
        emit(state.copyWith(fechaFilterEnabled: false));
      }

  FutureOr<void> _onEnableServicioFilterEvent(EnableServicioFilterEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
        emit(state.copyWith(servicioFilterEnabled: true));
      }

  FutureOr<void> _onDisableServicioFilterEvent(DisableServicioFilterEvent event,
      Emitter<EstadiaPacienteFilterState> emit) {
        emit(state.copyWith(servicioFilterEnabled: false));
      }
}

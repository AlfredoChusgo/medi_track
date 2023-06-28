import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medi_track_dora/repositories/estadia_paciente_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../models/estadia_paciente_model.dart';
import '../../../models/paciente.dart';

part 'estadia_paciente_form_event.dart';
part 'estadia_paciente_form_state.dart';

class EstadiaPacienteFormBloc
    extends Bloc<EstadiaPacienteFormEvent, EstadiaPacienteFormState> {
  final EstadiaPacienteRepository estadiaPacienteRepository;
  EstadiaPacienteFormBloc({required this.estadiaPacienteRepository})
      : super(EstadiaPacienteFormDataState.empty()) {
    on<ReadEstadiaPacienteFormEvent>(_onReadEstadiaPacienteFormEvent);
    on<NewEstadiaPacienteFormEvent>(_onNewEstadiaPacienteFormEvent);
    on<EditEstadiaPacienteFormEvent>(_onEditEstadiaPacienteFormEvent);

    on<SaveEstadiaPacienteFormEvent>(_onSaveEstadiaPacienteFormEvent);
    on<UpdateEstadiaPacienteFormEvent>(_onUpdateEstadiaPacienteFormEvent);
    on<DeleteEstadiaPacienteFormEvent>(_onDeleteEstadiaPacienteFormEvent);
  }

  FutureOr<void> _onNewEstadiaPacienteFormEvent(
      NewEstadiaPacienteFormEvent event,
      Emitter<EstadiaPacienteFormState> emit) {
    emit(EstadiaPacienteFormDataState.empty()
        .copyWith(paciente: event.paciente));
  }

  FutureOr<void> _onEditEstadiaPacienteFormEvent(
      EditEstadiaPacienteFormEvent event,
      Emitter<EstadiaPacienteFormState> emit) {
    emit(EstadiaPacienteFormDataState.empty().copyWith(
        id: event.estadiaPaciente.id,
        paciente: event.estadiaPaciente.paciente,
        fechaIngreso: event.estadiaPaciente.fechaIngreso,
        fechaEgreso: event.estadiaPaciente.fechaEgreso,
        accionesRealizadas: event.estadiaPaciente.accionesRealizadas,
        observaciones: event.estadiaPaciente.observaciones,
        diagnostico: event.estadiaPaciente.diagnostico,
        tipoServicio: event.estadiaPaciente.tipoServicio,
        readOnly: false));
  }

  FutureOr<void> _onReadEstadiaPacienteFormEvent(
      ReadEstadiaPacienteFormEvent event,
      Emitter<EstadiaPacienteFormState> emit) {
    emit(EstadiaPacienteFormDataState.empty().copyWith(
        id: event.estadiaPaciente.id,
        paciente: event.estadiaPaciente.paciente,
        fechaIngreso: event.estadiaPaciente.fechaIngreso,
        fechaEgreso: event.estadiaPaciente.fechaEgreso,
        accionesRealizadas: event.estadiaPaciente.accionesRealizadas,
        observaciones: event.estadiaPaciente.observaciones,
        diagnostico: event.estadiaPaciente.diagnostico,
        tipoServicio: event.estadiaPaciente.tipoServicio,
        readOnly: true));
  }

  FutureOr<void> _onSaveEstadiaPacienteFormEvent(
      SaveEstadiaPacienteFormEvent event,
      Emitter<EstadiaPacienteFormState> emit) {
    try {
      Future.delayed(const Duration(seconds: 1));
      estadiaPacienteRepository.saveEstadiaPaciente(event.estadiaPaciente);
      emit(EstadiaPacienteAddedSuccessfully(
          message: "Estadia guardada exitosamente!"));
    } catch (error) {
      emit(EstadiaPacientedError(
          message: "!Ocurrio un error! $error"));
    }
  }

  FutureOr<void> _onUpdateEstadiaPacienteFormEvent(
      UpdateEstadiaPacienteFormEvent event,
      Emitter<EstadiaPacienteFormState> emit) {
    try {
      Future.delayed(const Duration(seconds: 1));
      estadiaPacienteRepository.updateEstadiaPaciente(event.estadiaPaciente);
      emit(EstadiaPacienteUpdatedSuccessfully(
          message: "Estadia actualizada exitosamente!"));
    } catch (error) {
      emit(EstadiaPacientedError(
          message: "!Ocurrio un error! $error"));
    }
  }

  FutureOr<void> _onDeleteEstadiaPacienteFormEvent(DeleteEstadiaPacienteFormEvent event, Emitter<EstadiaPacienteFormState> emit) {
        try {
      Future.delayed(const Duration(seconds: 1));
      estadiaPacienteRepository.deleteEstadiaPaciente(event.id);
      emit(EstadiaPacienteDeletedSuccessfully(
          message: "Estadia eliminada exitosamente!",id:event.id));
    } catch (error) {
      emit(EstadiaPacientedError(
          message: "!Ocurrio un error! $error"));
    }
  }
}

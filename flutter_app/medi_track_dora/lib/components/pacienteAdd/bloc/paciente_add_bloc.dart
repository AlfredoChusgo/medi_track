import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../pacienteHome/paciente.dart';
import '../../pacienteHome/paciente_repository.dart';

part 'paciente_add_event.dart';
part 'paciente_add_state.dart';

class PacienteAddBloc extends Bloc<PacienteAddEvent, PacienteAddState> {
  PacienteRepository pacienteRepository;

  PacienteAddBloc({required this.pacienteRepository})
      : super(PacienteAddFormState.Initial()) {
    on<PacienteAddEvent>(_onPacienteAddEvent);
  }

  Future<FutureOr<void>> _onPacienteAddEvent(
      PacienteAddEvent event, Emitter<PacienteAddState> emit) async {
    if (state is PacienteAddFormState) {
      PacienteAddFormState pacienteAddFormState = state as PacienteAddFormState;
      switch (event.runtimeType) {
        case CIChanged:
          CIChanged ciEvent = event as CIChanged;
          emit(pacienteAddFormState.copyWith(ci: ciEvent.ci));
          break;
        case NombreChanged:
          NombreChanged nombreEvent = event as NombreChanged;
          emit(pacienteAddFormState.copyWith(nombre: nombreEvent.nombre));
          break;
        case ApellidoPaternoChanged:
          ApellidoPaternoChanged apellidoPaternoEvent =
              event as ApellidoPaternoChanged;
          emit(pacienteAddFormState.copyWith(
              apellidoPaterno: apellidoPaternoEvent.apellidoPaterno));
          break;
        case ApellidoMaternoChanged:
          ApellidoMaternoChanged apellidoMaternoEvent =
              event as ApellidoMaternoChanged;
          emit(pacienteAddFormState.copyWith(
              apellidoMaterno: apellidoMaternoEvent.apellidoMaterno));
          break;
        case FechaNacimientoChanged:
          FechaNacimientoChanged fechaNacimientoEvent =
              event as FechaNacimientoChanged;
          emit(pacienteAddFormState.copyWith(
              fechaNacimiento: fechaNacimientoEvent.fechaNacimiento));
          break;
        case SexoChanged:
          SexoChanged sexoEvent = event as SexoChanged;
          // Handle SexoChanged event
          emit(pacienteAddFormState.copyWith(sexo: sexoEvent.sexo));
          break;
        case OcupacionChanged:
          OcupacionChanged ocupacionEvent = event as OcupacionChanged;
          // Handle OcupacionChanged event
          emit(pacienteAddFormState.copyWith(
              ocupacion: ocupacionEvent.ocupacion));
          break;
        case ProcedenciaChanged:
          ProcedenciaChanged procedenciaEvent = event as ProcedenciaChanged;
          // Handle ProcedenciaChanged event
          emit(pacienteAddFormState.copyWith(
              procedencia: procedenciaEvent.procedencia));
          break;
        case TelefonoCelularChanged:
          TelefonoCelularChanged telefonoCelularEvent =
              event as TelefonoCelularChanged;
          // Handle TelefonoCelularChanged event
          emit(pacienteAddFormState.copyWith(
              telefonoCelular: telefonoCelularEvent.telefonoCelular));
          break;
        case TelefonoFijoChanged:
          TelefonoFijoChanged telefonoFijoEvent = event as TelefonoFijoChanged;
          // Handle TelefonoFijoChanged event
          emit(pacienteAddFormState.copyWith(
              telefonoFijo: telefonoFijoEvent.telefonoFijo));
          break;
        case DireccionResidenciaChanged:
          DireccionResidenciaChanged direccionResidenciaEvent =
              event as DireccionResidenciaChanged;
          // Handle DireccionResidenciaChanged event
          emit(pacienteAddFormState.copyWith(
              direccionResidencia:
                  direccionResidenciaEvent.direccionResidencia));
          break;
        case PacienteAddNewEvent:
          emit(PacienteAddFormState.Initial());
        case PacienteEditEvent:
          PacienteEditEvent editPacienteEvent = event as PacienteEditEvent;
          emit(PacienteAddFormState.copyWith(
              paciente: editPacienteEvent.paciente));
          break;

        case ContactoEmergenciaAdded:
          ContactoEmergenciaAdded contactoEmergenciaAdded =
              event as ContactoEmergenciaAdded;
          var list = [
            ...pacienteAddFormState.contactosEmergencia,
            contactoEmergenciaAdded.contactoEmergencia
          ];
          emit(pacienteAddFormState.copyWith(contactosEmergencia: list));
          break;
        case ContactosEmergenciaUpdated:
          ContactosEmergenciaUpdated contactoEmergenciaUpdated =
              event as ContactosEmergenciaUpdated;
          var list = [
            ...pacienteAddFormState.contactosEmergencia.where((element) =>
                element.id != contactoEmergenciaUpdated.contactoEmergencia.id),
            contactoEmergenciaUpdated.contactoEmergencia
          ];
          emit(pacienteAddFormState.copyWith(contactosEmergencia: list));
          break;
        case ContactosEmergenciaDeleted:
          ContactosEmergenciaDeleted contactosEmergenciaDeleted =
              event as ContactosEmergenciaDeleted;
          var list = [
            ...pacienteAddFormState.contactosEmergencia
                .where((element) => element.id != contactosEmergenciaDeleted.id)
          ];
          emit(pacienteAddFormState.copyWith(contactosEmergencia: list));
          break;

        case PacienteSubmit:
          PacienteAddFormState pacienteAddFormState =
              state as PacienteAddFormState;

          try {
            pacienteRepository.savePaciente(pacienteAddFormState.toPaciente());
            //await Future.delayed(const Duration(seconds: 3));
            emit(PacienteSavedSuccessfully());
            //emit(pacienteAddFormState.copyWith());
          } catch (error) {
            emit(ErrorDuringSaved(errorMessage: '$error'));
          }

          break;
        default:
          // Handle unknown event
          break;
      }
    }
  }
}

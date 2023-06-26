import 'dart:convert';
import 'package:flutter/services.dart';

import 'in_memory_paciente_repository.dart';
import 'paciente_repository.dart';
import '../models/estadia_paciente_filter_model.dart';
import '../models/estadia_paciente_model.dart';
import 'estadia_paciente_repository.dart';

class InMemoryEstadiaPacienteRepository implements EstadiaPacienteRepository {
  static bool dataLoaded = false;
  static List<EstadiaPaciente> list = [];
  static PacienteRepository pacienteRepository = InMemoryPacienteRepository();

  static Future<List<EstadiaPaciente>> loadData() async {
    if (dataLoaded) {
      return list;
    }
    await Future.delayed(const Duration(seconds: 1));

    String jsonData =
        await rootBundle.loadString('assets/estadia_pacientes.json');

    final List<dynamic> jsonList = json.decode(jsonData);
    list = jsonList.map((json) => EstadiaPaciente.fromJson(json)).toList();

    for (int i = 0; i < list.length; i++) {
      //for(EstadiaPaciente estadiaPaciente in list){
      var estadiaPaciente = list[i];
      var paciente =
          await pacienteRepository.getPaciente(estadiaPaciente.paciente.id);
      list[i] = estadiaPaciente.copyWith(paciente: paciente);
    }
    dataLoaded = true;
    return list;
  }

  @override
  Future<EstadiaPaciente> getEstadiaPaciente(String id) async {
    List<EstadiaPaciente> list = await loadData();
    return list.first;
  }

  @override
  Future<List<EstadiaPaciente>> getEstadiaPacientes() async {
    List<EstadiaPaciente> list = await loadData();
    return list;
  }

  @override
  Future<void> saveEstadiaPaciente(EstadiaPaciente model) async {
    await Future.delayed(const Duration(seconds: 0));
    list.add(model);
  }

  @override
  Future<void> deleteEstadiaPaciente(String id) async {
    List<EstadiaPaciente> localList = await loadData();
    list = [...localList.where((element) => element.id != id).toList()];
  }

  @override
  Future<void> updateEstadiaPaciente(EstadiaPaciente model) async {
    List<EstadiaPaciente> localList = await loadData();
    list = [
      ...localList.where((element) => element.id != model.id).toList(),
      model
    ];
  }

  @override
  Future<List<EstadiaPaciente>> getEstadiaPacientesWithFilter(
      EstadiaPacienteFilter filterState) async {
    List<EstadiaPaciente> list = await loadData();
    //
    return list.where((estadiaPaciente) {
      // Filter by pacienteName
      // if (filterState.pacienteFilterEnabled) {
      //   final pacienteNameFilter = filterState.pacienteName.toLowerCase();
      //   final estadiaPacienteName =
      //       estadiaPaciente.paciente.nombre.toLowerCase();
      //   if (!estadiaPacienteName.contains(pacienteNameFilter)) {
      //     return false;
      //   }
      // }

      // Filter by paciente
      if (filterState.pacienteFilterEnabled) {
        final pacienteFilter = filterState.paciente;
        if (estadiaPaciente.paciente != pacienteFilter) {
          return false;
        }
      }

      if (filterState.fechaFilterEnabled) {
        // Filter by fechaIngreso
        final fechaIngresoInicioFilter = filterState.fechaIngresoInicio;
        final fechaIngresoFinFilter = filterState.fechaIngresoFin;
        final fechaIngreso = estadiaPaciente.fechaIngreso;
        if (fechaIngreso.isBefore(fechaIngresoInicioFilter)) {
          return false;
        }
        if (fechaIngreso.isAfter(fechaIngresoFinFilter)) {
          return false;
        }
      }

      // Filter by tipoServicio
      if (filterState.servicioFilterEnabled) {
        final tipoServicioFilter = filterState.tipoServicio;
        if (estadiaPaciente.tipoServicio != tipoServicioFilter) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}

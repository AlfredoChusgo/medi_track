import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'paciente.dart';
import 'paciente_repository.dart';

class InMemoryPacienteRepository implements PacienteRepository {
  static bool dataLoaded = false;
  static List<Paciente> list = [];
  static Future<List<Paciente>> loadData() async {

    if(dataLoaded){
      return list;
    }
    await Future.delayed(const Duration(seconds: 1));

    String jsonData = await rootBundle.loadString('assets/pacientes.json');

    final List<dynamic> jsonList = json.decode(jsonData);
    list = jsonList.map((json) => Paciente.fromJson(json)).toList();
    dataLoaded = true;
    return list;
  }

  @override
  Future<Paciente> getPaciente(String id) async {
    List<Paciente> list = await loadData();
    return list.first;
  }

  @override
  Future<List<Paciente>> getPacientes() async {
    List<Paciente> list = await loadData();
    return list;
  }
  
  @override
  Future<void> SavePaciente(Paciente model) async {
    await Future.delayed(const Duration(seconds: 0));
    list.add(model);
  }
}

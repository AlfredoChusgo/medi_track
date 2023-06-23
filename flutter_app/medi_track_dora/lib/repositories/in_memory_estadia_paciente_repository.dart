import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../models/estadia_paciente.dart';
import 'estadia_paciente_repository.dart';


class InMemoryEstadiaPacienteRepository implements EstadiaPacienteRepository {
  static bool dataLoaded = false;
  static List<EstadiaPaciente> list = [];
  static Future<List<EstadiaPaciente>> loadData() async {

    if(dataLoaded){
      return list;
    }
    await Future.delayed(const Duration(seconds: 1));

    String jsonData = await rootBundle.loadString('assets/estadia_pacientes.json');

    final List<dynamic> jsonList = json.decode(jsonData);
    list = jsonList.map((json) => EstadiaPaciente.fromJson(json)).toList();
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
    list = [...localList.where((element) => element.id!=id).toList()];     
  }
  
  @override
  Future<void> updateEstadiaPaciente(EstadiaPaciente model) async {
    List<EstadiaPaciente> localList = await loadData();
    list = [...localList.where((element) => element.id!=model.id).toList(),model];   
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'paciente.dart';
import 'paciente_repository.dart';

class InMemoryPacienteRepository implements PacienteRepository {

  Future<List<Paciente>> loadData() async {
    // Simulating an asynchronous data fetch, such as making an API call
    await Future.delayed(const Duration(seconds: 0));

    
    // Replace this with your actual data loading logic
    // final currentDirectory = Directory.current;
    // final file = File('/lib/assets/pacientes.json');
    // final jsonData = await file.readAsString();
    String jsonData = await rootBundle.loadString('assets/pacientes.json');

    final List<dynamic> jsonList = json.decode(jsonData);

    // Parse the JSON data into ContactoEmergencia objects
    return jsonList.map((json) => Paciente.fromJson(json)).toList();
    //return jsonList;
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
}

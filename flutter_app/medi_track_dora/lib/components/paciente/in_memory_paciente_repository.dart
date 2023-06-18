import 'dart:convert';
import 'dart:io';

import 'paciente.dart';
import 'paciente_repository.dart';

class InMemoryPacienteRepository implements PacienteRepository {

  Future<List<Paciente>> loadData() async {
    // Simulating an asynchronous data fetch, such as making an API call
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with your actual data loading logic
    final file = File('path/to/paciente.json');
    final jsonData = await file.readAsString();

    final List<dynamic> jsonList = json.decode(jsonData);

    // Parse the JSON data into ContactoEmergencia objects
    return jsonList.map((json) => Paciente.fromJson(json)).toList();
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



import 'paciente.dart';

abstract class PacienteRepository {
  
  Future<List<Paciente>> getPacientesFiltered(String name);
  Future<List<Paciente>> getPacientes();
  Future<Paciente> getPaciente(String id);

  Future<void> savePaciente(Paciente model);
  Future<void> updatePaciente(Paciente model);
  Future<void> deletePaciente(String id);
}


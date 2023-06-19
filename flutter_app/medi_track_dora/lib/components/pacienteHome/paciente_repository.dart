

import 'paciente.dart';

abstract class PacienteRepository {
  
  Future<List<Paciente>> getPacientes();
  Future<Paciente> getPaciente(String id);
}


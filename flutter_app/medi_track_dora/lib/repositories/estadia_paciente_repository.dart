

import '../models/estadia_paciente_model.dart';

abstract class EstadiaPacienteRepository {
  
  Future<List<EstadiaPaciente>> getEstadiaPacientes();
  Future<EstadiaPaciente> getEstadiaPaciente(String id);

  Future<void> saveEstadiaPaciente(EstadiaPaciente model);
  Future<void> updateEstadiaPaciente(EstadiaPaciente model);
  Future<void> deleteEstadiaPaciente(String id);
}


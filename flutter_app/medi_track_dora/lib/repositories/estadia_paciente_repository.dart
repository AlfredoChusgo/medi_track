

import '../models/estadia_paciente_filter_model.dart';
import '../models/estadia_paciente_model.dart';

abstract class EstadiaPacienteRepository {
  
  Future<List<EstadiaPaciente>> getEstadiaPacientes();
  Future<List<EstadiaPaciente>> getEstadiaPacientesWithFilter(EstadiaPacienteFilter filterState);
  Future<EstadiaPaciente> getEstadiaPaciente(String id);

  Future<void> saveEstadiaPaciente(EstadiaPaciente model);
  Future<void> updateEstadiaPaciente(EstadiaPaciente model);
  Future<void> deleteEstadiaPaciente(String id);
}


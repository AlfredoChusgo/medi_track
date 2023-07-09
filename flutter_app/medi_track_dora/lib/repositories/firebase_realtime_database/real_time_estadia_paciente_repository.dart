import 'package:firebase_database/firebase_database.dart';
import 'package:medi_track_dora/models/estadia_paciente_filter_model.dart';

import 'package:medi_track_dora/models/estadia_paciente_model.dart';
import 'package:medi_track_dora/models/paciente.dart';
import 'package:medi_track_dora/repositories/paciente_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../estadia_paciente_repository.dart';

import '../../helpers/sqlite_database_helper.dart';

class RealTimeEstadiaPacienteRepository implements EstadiaPacienteRepository {
  final PacienteRepository pacienteRepository;

  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference estadiaPacienteRef;

  RealTimeEstadiaPacienteRepository({required this.pacienteRepository}) {
    estadiaPacienteRef = database.ref("estadia_paciente");
  }

  @override
  Future<void> deleteEstadiaPaciente(String id) async {
    try {
      await estadiaPacienteRef.child(id).remove();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EstadiaPaciente> getEstadiaPaciente(String id) async {
    DataSnapshot snapshot = await estadiaPacienteRef.child(id).get();
    if (snapshot.exists) {
      //Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
      Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value! as Map<Object?, Object?>);
      EstadiaPaciente estadiaPaciente = EstadiaPaciente.fromJson(data);
      Paciente paciente =
          await pacienteRepository.getPaciente(estadiaPaciente.paciente.id);

      return estadiaPaciente.copyWith(paciente: paciente);
    } else {
      throw Exception("get paciente id:$id , not found");
    }
  }

  @override
  Future<List<EstadiaPaciente>> getEstadiaPacientes() async {
    final snapshot = await estadiaPacienteRef.get();
    List<EstadiaPaciente> estadiaPacientes = [];

    if (snapshot.value != null) {
      for (DataSnapshot snapshot in snapshot.children) {
        //Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value! as Map<Object?, Object?>);
        EstadiaPaciente estadiaPaciente = EstadiaPaciente.fromJson(data);
        Paciente paciente =
            await pacienteRepository.getPaciente(estadiaPaciente.paciente.id);
        estadiaPacientes.add(estadiaPaciente.copyWith(paciente: paciente));
      }
      return estadiaPacientes;
    } else {
      return estadiaPacientes;
    }
  }

  Future<void> loadPacientes(List<EstadiaPaciente> estadias) async {
    for (var i = 0; i < estadias.length; i++) {
      Paciente paciente =
          await pacienteRepository.getPaciente(estadias[i].paciente.id);
      estadias[i] = estadias[i].copyWith(paciente: paciente);
    }
  }

  @override
  Future<List<EstadiaPaciente>> getEstadiaPacientesWithFilter(
      EstadiaPacienteFilter filterState) async {
    List<EstadiaPaciente> list = await getEstadiaPacientes();
    final List<EstadiaPaciente> filteredList =  list.where((estadiaPaciente) {
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

    await loadPacientes(filteredList);
    return EstadiaPaciente.sortByUpdatedAt(filteredList);
  }

  @override
  Future<void> saveEstadiaPaciente(EstadiaPaciente estadiaPaciente) async {
    try {
      estadiaPacienteRef
          .child(estadiaPaciente.id)
          .set(estadiaPaciente.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEstadiaPaciente(EstadiaPaciente estadiaPaciente) async {
    try {
      await estadiaPacienteRef
          .child(estadiaPaciente.id)
          .update(estadiaPaciente.toJson());
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';

import '../../models/paciente.dart';
import '../paciente_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimePacienteRepository implements PacienteRepository {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference pacientesRef;
  RealTimePacienteRepository() {
    pacientesRef = database.ref("pacientes");
  }

  @override
  Future<void> deletePaciente(String id) async {
    try {
      await pacientesRef.child(id).remove();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Paciente> getPaciente(String id) async {
    DataSnapshot pacienteSnapshot = await pacientesRef.child(id).get();
    if (pacienteSnapshot.exists) {
      return pacienteFromSnapshot(pacienteSnapshot);
    } else {
      throw Exception("get paciente id:$id , not found");
    }
  }

  @override
  Future<List<Paciente>> getPacientes() async {
    try {
      final DataSnapshot snapshot = await pacientesRef.get();
      List<Paciente> pacientes = [];
      if (snapshot.value != null) {
        for (DataSnapshot snapshot in snapshot.children) {
          pacientes.add(pacienteFromSnapshot(snapshot));
        }
        return pacientes;
      } else {
        return pacientes;
      }
    } catch (e) {
      rethrow;
    }
  }

  Paciente pacienteFromSnapshot(DataSnapshot snapshot) {
    // todo reuse paciente fromMap code
    //Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
    Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value! as Map<Object?, Object?>);

    return Paciente(
      id: data['id'],
      ci: data['ci'],
      nombre: data['nombre'],
      apellidoPaterno: data['apellidoPaterno'],
      apellidoMaterno: data['apellidoMaterno'],
      fechaNacimiento: DateTime.parse(data['fechaNacimiento']),
      sexo: Sexo.values[data['sexo']],
      ocupacion: data['ocupacion'],
      procedencia: data['procedencia'],
      telefonoCelular: data['telefonoCelular'],
      telefonoFijo: data['telefonoFijo'],
      direccionResidencia: data['direccionResidencia'],
      contactosEmergencia:
          //List<ContactoEmergencia>.from(data['contactosEmergencia']),
          (jsonDecode(data['contactosEmergencia']) as List<dynamic>)
            .map((contactoJson) => ContactoEmergencia.fromJson(contactoJson))
            .toList(),
          
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      numeroHistoriaClinica: data['numeroHistoriaClinica'],
    );
  }

  @override
  Future<List<Paciente>> getPacientesFiltered(String name) async {
    List<Paciente> pacienteList = await getPacientes();

    return pacienteList.where((e) {
      String fullName =
          "${e.nombre} ${e.apellidoPaterno} ${e.apellidoMaterno}".toLowerCase();
      if (fullName.contains(name.toLowerCase())) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Future<void> savePaciente(Paciente paciente) async {
    try {
      pacientesRef.child(paciente.id).set(paciente.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePaciente(Paciente paciente) async {
    try {
      await pacientesRef.child(paciente.id).update(paciente.toJson());
    } catch (e) {
      rethrow;
    }
  }
}

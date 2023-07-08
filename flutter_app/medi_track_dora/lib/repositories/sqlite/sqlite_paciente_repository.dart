import 'package:sqflite/sqflite.dart';

import '../../models/paciente.dart';
import '../paciente_repository.dart';
import '../../helpers/sqlite_database_helper.dart';

class SqlitePacienteRepository implements PacienteRepository {
  SqlitePacienteRepository();

  @override
  Future<void> deletePaciente(String id) async {
    await SQLiteDatabaseHelper.executeOperation<void>((Database database) {
      return database.delete(
        'pacientes',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  @override
  Future<Paciente> getPaciente(String id) async {
    final List<Map<String, dynamic>> result =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, dynamic>>>(
            (Database database) {
      return database.query(
        'pacientes',
        where: 'id = ?',
        whereArgs: [id],
      );
    });

    if (result.isNotEmpty) {
      return Paciente.fromMap(result.first);
    } else {
      throw Exception("get paciente id:$id , not found");
    }
  }

  @override
  Future<List<Paciente>> getPacientes() async {
    final pacientesData =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.query('pacientes');
    });
    final pacientes =
        pacientesData.map((data) => Paciente.fromMap(data)).toList();
    return Paciente.sortByUpdatedAt(pacientes);
  }

  @override
  Future<List<Paciente>> getPacientesFiltered(String name) async {
    final List<Map<String, dynamic>> result =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.query(
        'pacientes',
        where: 'nombre LIKE ?',
        whereArgs: ['%$name%'],
      );
    });
    return result.map((map) => Paciente.fromMap(map)).toList();
  }

  @override
  Future<void> savePaciente(Paciente paciente) async {
    await SQLiteDatabaseHelper.executeOperation<int>((Database database) {
      return database.insert('pacientes', paciente.toMap());
    });
  }

  @override
  Future<void> updatePaciente(Paciente paciente) async {
    await SQLiteDatabaseHelper.executeOperation<int>((Database database) {
      return database.update('pacientes', paciente.toMap(),
          where: 'id = ?', whereArgs: [paciente.id]);
    });
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import '../models/paciente.dart';
import 'paciente_repository.dart';
import 'sqlite_database_helper.dart';

class SqlitePacienteRepository implements PacienteRepository {
  final Future<Database> _database;
  SqlitePacienteRepository() : _database = _openDatabase();

  static Future<Database> _openDatabase() async {
    return await SQLiteDatabaseHelper.openDatabaseHelper();
  }

  @override
  Future<void> deletePaciente(String id) async {
    await (await _database).delete(
      'pacientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Paciente> getPaciente(String id) async {
    final List<Map<String, dynamic>> result = await (await _database).query(
      'pacientes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Paciente.fromMap(result.first);
    } else {
      throw Exception("get paciente id:$id , not found");
    }
  }

  @override
  Future<List<Paciente>> getPacientes() async {
    final db = await _database;
    final pacientesData = await db.query('pacientes');
    final pacientes =
        pacientesData.map((data) => Paciente.fromMap(data)).toList();
    // for (var paciente in pacientes) {
    //   var contactosEmergencia = await _getContactosEmergencia(paciente.id);
    //   paciente = paciente.copyWith(contactosEmergencia: contactosEmergencia);
    // }
    return pacientes;
  }

  @override
  Future<List<Paciente>> getPacientesFiltered(String name) async {
    final List<Map<String, dynamic>> result = await (await _database).query(
      'pacientes',
      where: 'nombre LIKE ?',
      whereArgs: ['%$name%'],
    );

    return result.map((map) => Paciente.fromMap(map)).toList();
  }

  @override
  Future<void> savePaciente(Paciente paciente) async {
    final db = await _database;
    await db.insert('pacientes', paciente.toMap());
    await _addContactosEmergencia(paciente.id, paciente.contactosEmergencia);
  }

  @override
  Future<void> updatePaciente(Paciente paciente) async {
    final db = await _database;
    await db.update('pacientes', paciente.toMap(),
        where: 'id = ?', whereArgs: [paciente.id]);
  }

  Future<List<ContactoEmergencia>> _getContactosEmergencia(
      String pacienteId) async {
    final db = await _database;
    final contactosData = await db.query('contactos_emergencia',
        where: 'pacienteId = ?', whereArgs: [pacienteId]);
    return contactosData
        .map((data) => ContactoEmergencia.fromMap(data))
        .toList();
  }

  Future<void> _addContactosEmergencia(
      String pacienteId, List<ContactoEmergencia> contactosEmergencia) async {
    final db = await _database;
    final batch = db.batch();
    for (var contacto in contactosEmergencia) {
      batch.insert('contactos_emergencia',
          contacto.toMap()..['pacienteId'] = pacienteId);
    }
    await batch.commit(noResult: true);
  }

  Future<void> _deleteContactosEmergencia(String pacienteId) async {
    final db = await _database;
    await db.delete('contactos_emergencia',
        where: 'pacienteId = ?', whereArgs: [pacienteId]);
  }
}

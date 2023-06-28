import 'package:medi_track_dora/models/estadia_paciente_filter_model.dart';

import 'package:medi_track_dora/models/estadia_paciente_model.dart';
import 'package:sqflite/sqflite.dart';

import 'estadia_paciente_repository.dart';
import 'package:path/path.dart' as path;

class SqliteEstadiaPacienteRepository implements EstadiaPacienteRepository {

  final Future<Database> _database;

  SqliteEstadiaPacienteRepository() : _database = _openDatabase();

  static Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathToDatabase = path.join(dbPath, 'medi_track.db');

    return openDatabase(
      pathToDatabase,
      version: 1,
      onCreate: (db, version) {
        // Create tables if needed
        db.execute('''
          CREATE TABLE IF NOT EXISTS estadia_pacientes (
            id TEXT PRIMARY KEY,
            pacienteId TEXT,
            fechaIngreso INTEGER,
            fechaEgreso INTEGER,
            accionesRealizadas TEXT,
            observaciones TEXT,
            diagnostico TEXT,
            tipoServicio TEXT,
            FOREIGN KEY (pacienteId) REFERENCES pacientes (id)
          )
        ''');
      },
    );
  }

  @override
  Future<void> deleteEstadiaPaciente(String id) async {
    await(await _database).delete(
      'estadia_pacientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<EstadiaPaciente> getEstadiaPaciente(String id) async{
    final List<Map<String, dynamic>> maps = await (await _database).query(
      'estadia_pacientes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return EstadiaPaciente.fromMap(maps.first);
    }else{
      throw Exception("get paciente id:$id , not found");
    }
  }

  @override
  Future<List<EstadiaPaciente>> getEstadiaPacientes() async{
    final db = await _database;
    final estadiasData = await db.query('estadia_pacientes');
    return estadiasData.map((data) => EstadiaPaciente.fromMap(data)).toList();
  
  }

@override
  Future<List<EstadiaPaciente>> getEstadiaPacientesWithFilter(EstadiaPacienteFilter filterState) {
    return Future.delayed(Duration.zero,()=>[]);
  }

  @override
  Future<void> saveEstadiaPaciente(EstadiaPaciente estadiaPaciente) async {
    final db = await _database;
    await db.insert('estadia_pacientes', estadiaPaciente.toMap());
  }

  @override
  Future<void> updateEstadiaPaciente(EstadiaPaciente estadiaPaciente) async {
    final db = await _database;
    await db.update('estadia_pacientes', estadiaPaciente.toMap(), where: 'id = ?', whereArgs: [estadiaPaciente.id]);
  }

}
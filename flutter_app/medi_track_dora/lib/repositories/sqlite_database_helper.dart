import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SQLiteDatabaseHelper {
  static Future<Database> openDatabaseHelper() async {
    try {
      final dbPath = await getDatabasesPath();
      final pathToDatabase =
          path.join(dbPath, 'medi_track.db'); // example 'medi_track.db'

      return openDatabase(
        pathToDatabase,
        version: 1,
        onCreate: (db, version) {
          // Create tables if needed
          db.execute('''
          CREATE TABLE IF NOT EXISTS pacientes (
            id TEXT PRIMARY KEY,
            ci TEXT,
            nombre TEXT,
            apellidoPaterno TEXT,
            apellidoMaterno TEXT,
            fechaNacimiento INTEGER,
            sexo TEXT,
            ocupacion TEXT,
            procedencia TEXT,
            telefonoCelular INTEGER,
            telefonoFijo INTEGER,
            direccionResidencia TEXT,
            contactosEmergencia TEXT
          )
        ''');

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
    } catch (e) {
      rethrow;
    }
  }
}

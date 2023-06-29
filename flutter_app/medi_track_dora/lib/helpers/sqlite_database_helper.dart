import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
            contactosEmergencia TEXT,
            createdAt INTEGER,
            updatedAt INTEGER
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
            createdAt INTEGER,
            updatedAt INTEGER,
            FOREIGN KEY (pacienteId) REFERENCES pacientes (id)
          )
        ''');
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> exportDatabase(Database database) async {
    // Get the path to the documents directory
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databasePath = path.join(documentsDirectory.path, 'database.db');

    // Close the database connection
    await database.close();

    // Copy the database file to the documents directory
    await File(database.path).copy(databasePath);

    return databasePath;
  }

  static Future<void> shareDatabaseFile(String filePath) async {
    var result = await Share.shareXFiles([XFile(filePath)],
        subject: 'This is a backup file.');

    switch (result.status) {
      case ShareResultStatus.success:
        //print('Thank you for sharing the picture!');
        break;
      default:
        throw Exception("Something happend the backup was not shared");
    }
  }

  static Future<void> exportAndShareDatabase() async {
    final databasePath = await exportDatabase(await openDatabaseHelper());
    await shareDatabaseFile(databasePath);
  }
}

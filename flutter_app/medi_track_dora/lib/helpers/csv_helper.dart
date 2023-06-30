import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:excel/excel.dart';
import 'export_import_helper.dart';
import 'sqlite_database_helper.dart';
import 'package:path/path.dart' as path;

class CsvHelper {
  static Future<String> exportAsCsv() async {
    const pacientesQuery = 'SELECT * FROM pacientes';
    const estadiaPacientesQuery = 'SELECT * FROM estadia_pacientes';

    final pacientesResult =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.rawQuery(pacientesQuery);
    });
    final estadiaPacientesResult =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.rawQuery(estadiaPacientesQuery);
    });
    final pacientesCsvData =
        //const ListToCsvConverter().convert(pacientesResult.cast<List?>());
        const ListToCsvConverter().convert(
            pacientesResult.map((row) => row.values.toList()).toList());
    final estadiaPacientesCsvData = const ListToCsvConverter().convert(
        estadiaPacientesResult.map((row) => row.values.toList()).toList());

    final excel = Excel.createExcel();
    excel.sheets.remove(0);
    //Add Pacientes sheet
    //final pacientesSheet = excel.sheets['Pacientes'];

    List<List<String>> row =
        pacientesCsvData.split('\n').map((row) => row.split(',')).toList();
    for (var element in row) {
      excel.appendRow('pacientes', [...element]);
    }

// Add Estadia Pacientes sheet
    //final estadiaPacientesSheet = excel.sheets['Estadia Pacientes'];

    List<List<String>> rowEstadias = estadiaPacientesCsvData
        .split('\n')
        .map((row) => row.split(','))
        .toList();
    for (var element in rowEstadias) {
      excel.appendRow('estadia_pacientes', [...element]);
    }

    const excelFileName = 'medi_track.xlsx';
    final applicationDocumentDirectory =
        await getApplicationDocumentsDirectory();

    final fileFullPath =
        path.join(applicationDocumentDirectory.path, excelFileName);

    // Call function save() to download the file
    var fileBytes = excel.save();

    File(fileFullPath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    return fileFullPath;
  }

  static Future<void> exportAndShareCsv() async {
    final excelFilepath = await exportAsCsv();

    await shareFile(excelFilepath);

    //delete after export
    File file = File(excelFilepath);
    file.deleteSync();
  }

  static Future<void> shareFile(String filePath) async {
    try {
      var result = await Share.shareXFiles([XFile(filePath)],
          subject: 'This is a csv file with data.');
      switch (result.status) {
        case ShareResultStatus.success:
          //print('Thank you for sharing the picture!');
          break;
        case ShareResultStatus.dismissed:
          throw CancelledByUserException();
        default:
          throw Exception("Something happend the file was not shared");
      }
    } catch (e) {
      print(e);
    }
  }
}

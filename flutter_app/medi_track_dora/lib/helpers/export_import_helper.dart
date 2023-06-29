import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'sqlite_database_helper.dart';
import 'package:file_picker/file_picker.dart';

class ExportImportHelper {
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
      case ShareResultStatus.dismissed:
        throw CancelledByUserException();
      default:
        throw Exception("Something happend the backup was not shared");
    }
  }

  static Future<void> exportAndShareDatabase() async {
    final databasePath =
        await exportDatabase(await SQLiteDatabaseHelper.openDatabaseHelper());
    await shareDatabaseFile(databasePath);
  }

  static Future<void> selectAndImportDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      //allowedExtensions: ['bkapp'], // Replace with your desired extensions
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String filePath = file.path!;
      String fileName = file.name;

      if (validateFileExtension(fileName)) {
        // File extension is valid, process the file
        // Implement your logic here
        importDatabase(filePath);
      } else {
        // File extension is not valid
        // Display an error message or take appropriate action
        throw InvalidFileExtensionException();
      }
    } else {
      // User canceled file selection
      // Handle accordingly
      throw CancelledByUserException();
    }
  }

  static bool validateFileExtension(String fileName) {
    List<String> validExtensions = [
      'db'
    ]; // Replace with your desired extensions

    String extension = fileName.split('.').last.toLowerCase();
    return validExtensions.contains(extension);
  }

  //Future<void> importDatabase(File importFile) async {
  static Future<void> importDatabase(String filePath) async {
    final importFile = File(filePath);
  // Get the path to the application's document directory
  final directory = await getApplicationDocumentsDirectory();
  final databasePath = path.join(directory.path, 'medi_track.db');

  // Close the existing database connection if it's open
  await databaseFactory.deleteDatabase(databasePath);

  // Copy the imported file to the database location
  await importFile.copy(databasePath);
}
}

class CancelledByUserException implements Exception {
  final String message;

  CancelledByUserException([this.message = 'Cancelled by User']);

  @override
  String toString() => 'CancelledByUserException: $message';
}

class InvalidFileExtensionException implements Exception {
  final String message;

  InvalidFileExtensionException([this.message = 'Invalid file extension']);

  @override
  String toString() => 'InvalidFileExtensionException: $message';
}

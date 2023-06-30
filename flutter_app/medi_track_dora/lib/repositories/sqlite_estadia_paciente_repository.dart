import 'package:medi_track_dora/models/estadia_paciente_filter_model.dart';

import 'package:medi_track_dora/models/estadia_paciente_model.dart';
import 'package:medi_track_dora/models/paciente.dart';
import 'package:medi_track_dora/repositories/paciente_repository.dart';
import 'package:sqflite/sqflite.dart';

import 'estadia_paciente_repository.dart';

import '../helpers/sqlite_database_helper.dart';

class SqliteEstadiaPacienteRepository implements EstadiaPacienteRepository {
  final PacienteRepository pacienteRepository;
  SqliteEstadiaPacienteRepository({required this.pacienteRepository});

  @override
  Future<void> deleteEstadiaPaciente(String id) async {
    await SQLiteDatabaseHelper.executeOperation<int>((Database database) {
      return database.delete(
        'estadia_pacientes',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  @override
  Future<EstadiaPaciente> getEstadiaPaciente(String id) async {
    final List<Map<String, dynamic>> maps =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.query(
        'estadia_pacientes',
        where: 'id = ?',
        whereArgs: [id],
      );
    });

    if (maps.isNotEmpty) {
      return EstadiaPaciente.fromMap(maps.first);
    } else {
      throw Exception("get paciente id:$id , not found");
    }
  }

  @override
  Future<List<EstadiaPaciente>> getEstadiaPacientes() async {
    final estadiasData =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.query('estadia_pacientes');
    });

    List<EstadiaPaciente> estadias = estadiasData.map((data) {
      EstadiaPaciente estadia = EstadiaPaciente.fromMap(data);
      return estadia;
    }).toList();

    await loadPacientes(estadias);
    return EstadiaPaciente.sortByUpdatedAt(estadias);
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
    final queryBuilder =
        StringBuffer('SELECT * FROM estadia_pacientes WHERE 1=1');

    if (filterState.pacienteFilterEnabled) {
      queryBuilder.write(' AND pacienteId = ?');
    }

    if (filterState.fechaFilterEnabled) {
      queryBuilder.write(' AND fechaIngreso >= ? AND fechaIngreso <= ?');
    }

    if (filterState.servicioFilterEnabled) {
      queryBuilder.write(' AND tipoServicio = ?');
    }

    final query = queryBuilder.toString();

    final queryParams = <dynamic>[];

    if (filterState.pacienteFilterEnabled) {
      queryParams.add(filterState.paciente.id);
    }

    if (filterState.fechaFilterEnabled) {
      queryParams.add(filterState.fechaIngresoInicio);
      queryParams.add(filterState.fechaIngresoFin);
    }

    if (filterState.servicioFilterEnabled) {
      queryParams.add(filterState.tipoServicio.name);
    }

    final results =
        await SQLiteDatabaseHelper.executeOperation<List<Map<String, Object?>>>(
            (Database database) {
      return database.rawQuery(query, queryParams);
    });

    final estadias =
        results.map((row) => EstadiaPaciente.fromMap(row)).toList();
    await loadPacientes(estadias);
    return EstadiaPaciente.sortByUpdatedAt(estadias);
  }

  @override
  Future<void> saveEstadiaPaciente(EstadiaPaciente estadiaPaciente) async {
    await SQLiteDatabaseHelper.executeOperation<int>((Database database) {
      return database.insert('estadia_pacientes', estadiaPaciente.toMap());
    });
  }

  @override
  Future<void> updateEstadiaPaciente(EstadiaPaciente estadiaPaciente) async {
    await SQLiteDatabaseHelper.executeOperation<int>((Database database) {
      return database.update('estadia_pacientes', estadiaPaciente.toMap());
    });
  }
}

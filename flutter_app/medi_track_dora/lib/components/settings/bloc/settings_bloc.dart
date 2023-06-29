import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medi_track_dora/helpers/sqlite_database_helper.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ImportDataEvent>(_onImportDataEvent);
    on<ExportDataEvent>(_onExportDataEvent);
  }

  FutureOr<void> _onImportDataEvent(
      ImportDataEvent event, Emitter<SettingsState> emit) async {}

  FutureOr<void> _onExportDataEvent(
      ExportDataEvent event, Emitter<SettingsState> emit) async {
    try {
      await SQLiteDatabaseHelper.exportAndShareDatabase();
    } catch (e) {
      emit(DataTransferFailure(errorMessage: e.toString()));
    }
  }
}

part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class ImportDataEvent extends SettingsEvent {}

class ExportDataEvent extends SettingsEvent {}

class ExportAsCsv extends SettingsEvent {}

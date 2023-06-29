part of 'settings_bloc.dart';

@immutable
sealed class SettingsState extends Equatable {}

class SettingsInitial extends SettingsState {
  @override
  List<Object?> get props => [];
}

class ActionInProgress extends SettingsState {
  @override
  List<Object?> get props => [];
}

class DataTransferSuccess extends SettingsState {
  @override
  List<Object?> get props => [];
}

class DataTransferFailure extends SettingsState {
  final String errorMessage;

  DataTransferFailure({required this.errorMessage});

  @override  
  List<Object?> get props => [errorMessage];
}

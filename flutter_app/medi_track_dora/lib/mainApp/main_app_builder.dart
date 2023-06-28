import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/repositories/paciente_repository.dart';
import 'package:medi_track_dora/config/application_configuration.dart';
import 'package:medi_track_dora/mainApp/development_app.dart';
import 'package:medi_track_dora/mainApp/production_app.dart';

import '../components/estadiaPacienteFilter/bloc/estadia_paciente_filter_bloc.dart';
import '../components/estadiaPacienteForm/estadia_paciente.dart';
import '../components/estadiaPacienteHome/bloc/estadia_paciente_home_bloc.dart';
import '../components/pacienteAdd/bloc/paciente_add_bloc.dart';
import '../components/pacienteHome/bloc/paciente_home_bloc.dart';
import '../repositories/in_memory_paciente_repository.dart';
import '../components/search_app_bar/bloc/search_bar_bloc.dart';
import '../repositories/estadia_paciente_repository.dart';
import '../repositories/in_memory_estadia_paciente_repository.dart';

class MainAppBuilder {
  final ApplicationConfiguration config;
  late final PacienteRepository pacienteRepository;
  late final EstadiaPacienteRepository estadiaPacienteRepository;

  MainAppBuilder({required this.config}) {
    setupDependencies();
  }

  Widget build() {
    if (config.developmentConfig.isDevelopment) {
      return buildBlocProviders(
          DevelopmentApp(pacienteRepository: pacienteRepository));
    } else {
      return buildBlocProviders(
          ProductionApp(pacienteRepository: pacienteRepository));
    }
  }

  Widget buildBlocProviders(Widget app) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => PacienteHomeBloc(
          pacienteRepository: pacienteRepository,
        )..add(PacienteHomeRefreshEvent()),
      ),
      BlocProvider(
        create: (context) =>
            PacienteAddBloc(pacienteRepository: pacienteRepository),
      ),
      BlocProvider(
        create: (context) => SearchBarBloc(),
      ),
      BlocProvider(
        create: (context) =>
            EstadiaPacienteFilterBloc(pacienteRepository: pacienteRepository),
      ),
      BlocProvider(
        create: (context) =>
            EstadiaPacienteHomeBloc(repository: estadiaPacienteRepository),
      ),
      BlocProvider(
        create: (context) =>
            EstadiaPacienteFormBloc(estadiaPacienteRepository: estadiaPacienteRepository),
      ),
    ], child: app);
  }

  void setupDependencies() {
    //repositories
    if (config.developmentConfig.isDevelopment) {
      pacienteRepository = InMemoryPacienteRepository(dataSize: config.developmentConfig.fakeDataSize);
      estadiaPacienteRepository = InMemoryEstadiaPacienteRepository(dataSize: config.developmentConfig.fakeDataSize,pacienteRepository: pacienteRepository);
    } else {
      pacienteRepository = InMemoryPacienteRepository(dataSize: config.developmentConfig.fakeDataSize);
      estadiaPacienteRepository = InMemoryEstadiaPacienteRepository(dataSize: config.developmentConfig.fakeDataSize,pacienteRepository: pacienteRepository);
    }
  }
}

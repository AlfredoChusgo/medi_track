import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/app.dart';
import 'package:medi_track_dora/components/estadiaPacienteFilter/bloc/estadia_paciente_filter_bloc.dart';
import 'package:medi_track_dora/repositories/in_memory_estadia_paciente_repository.dart';

import 'components/estadiaPacienteHome/bloc/estadia_paciente_home_bloc.dart';
import 'components/pacienteAdd/bloc/paciente_add_bloc.dart';
import 'components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'components/pacienteHome/in_memory_paciente_repository.dart';
import 'components/search_app_bar/bloc/search_bar_bloc.dart';

void main() {
  var repository =  InMemoryPacienteRepository();
  var estadiaPaciente =  InMemoryEstadiaPacienteRepository();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PacienteHomeBloc(
              pacienteRepository: repository,
            )..add(PacienteHomeRefreshEvent()),
          ),
          BlocProvider(
            create: (context) => PacienteAddBloc(
                pacienteRepository: repository),
          ),
          BlocProvider(
            create: (context) => SearchBarBloc(),
          ),
          BlocProvider(
            create: (context) => EstadiaPacienteFilterBloc(pacienteRepository: repository),
          ),
          BlocProvider(
            create: (context) => EstadiaPacienteHomeBloc(repository: estadiaPaciente),
          ),
        ],
        child: App(
          pacienteRepository: InMemoryPacienteRepository(),
        )),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: App(pacienteRepository: InMemoryPacienteRepository(),),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/app.dart';

import 'components/pacienteAdd/bloc/paciente_add_bloc.dart';
import 'components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'components/pacienteHome/in_memory_paciente_repository.dart';

void main() {
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PacienteHomeBloc(
              pacienteRepository: InMemoryPacienteRepository(),
            )..add(PacienteHomeRefreshEvent()),
          ),
          BlocProvider(
            create: (context) => PacienteAddBloc(
                pacienteRepository: InMemoryPacienteRepository()),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/home/view/home_page.dart';
import 'components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'components/pacienteHome/paciente_repository.dart';
import 'components/pacienteHome/view/paciente_home_page.dart';

class App extends StatelessWidget {
  const App({required this.pacienteRepository, super.key});

  final PacienteRepository pacienteRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PacienteHomeBloc(
            pacienteRepository: pacienteRepository,
          )..add(PacienteHomeRefreshEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Medi track Dora',
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
          '/pacienteHome': (_) => const PacienteHomePage(),
          //'/cart': (_) => const CartPage(),
        },
      ),
    );
  }
}
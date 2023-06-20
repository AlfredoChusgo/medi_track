import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/pacienteAdd/view/paciente_add_page.dart';

import 'components/home/view/home_page.dart';
import 'components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'components/pacienteHome/paciente_repository.dart';
import 'components/pacienteHome/view/paciente_home_page.dart';

class App extends StatelessWidget {
  const App({required this.pacienteRepository, super.key});

  final PacienteRepository pacienteRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Medi track Dora',
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/pacienteHome': (_) {
          //BlocProvider.of<PacienteHomeBloc>(context).add(PacienteHomeRefreshEvent());
          context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          return const PacienteHomePage();
        } ,
        '/pacienteAdd': (_) => const PacienteAddPage(),
        //'/cart': (_) => const CartPage(),
      },
    );
  }
}
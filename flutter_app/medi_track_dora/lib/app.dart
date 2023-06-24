import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/contactoEmergenciaAdd/view/contacto_emergencia_page.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/bloc/estadia_paciente_home_bloc.dart';
import 'package:medi_track_dora/components/pacienteAdd/view/paciente_add_page.dart';

import 'components/estadiaPacienteHome/view/estadia_paciente_home_page.dart';
import 'components/home/view/home_page.dart';
import 'components/pacienteAdd/bloc/paciente_add_bloc.dart';
import 'components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'components/pacienteHome/paciente.dart';
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
        '/': (_) {
          //context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          context.read<EstadiaPacienteHomeBloc>().add(EstadiaPacienteHomeRefreshEvent());
          //return const HomePage();} ,
          return EstadiaPacienteHomePage();} ,
        '/pacienteHome': (_) {
          context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          return const PacienteHomePage();
        },
        '/pacienteAdd': (buildContext) => PacienteAddPage(
              saveButtonText: "Guardar",
              callback: () {
                BlocProvider.of<PacienteAddBloc>(buildContext)
                    .add(const PacientePerformSave());
                //Navigator.pop(buildContext);
              }
            ),
        '/pacienteEdit': (buildContext) => PacienteAddPage(
              saveButtonText: "Actualizar",
              callback: () {
                BlocProvider.of<PacienteAddBloc>(buildContext)
                    .add(const PacientePerformUpdate());
              }
            ),
        '/contactoEmergenciaAdd': (buildContext) => ContactoEmergenciaPage(
              model: ContactoEmergencia.empty(),
              saveButtonText: "Guardar",
              callback: (contactoEmergencia) {
                BlocProvider.of<PacienteAddBloc>(context)
                    .add(ContactoEmergenciaAdded(contactoEmergencia));
                Navigator.pop(buildContext);
              },
            ),
        //'/cart': (_) => const CartPage(),
      },
    );
  }
}

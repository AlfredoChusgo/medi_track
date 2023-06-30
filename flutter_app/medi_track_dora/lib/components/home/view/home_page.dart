import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/estadia_paciente.dart';

import '../../pacienteHome/bloc/paciente_home_bloc.dart';
import '../../pacienteHome/view/paciente_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Administracion',
          ),
        ),
        bottomNavigationBar: const NavigationExample(),
      ),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.personal_injury_outlined),
            label: 'Pacientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_hospital),
            label: 'Estadias',
          )
        ],
      ),
      body: <Widget>[
        Container(
          //color: Colors.red,
          alignment: Alignment.center,
          child: getPacienteHomePage(),
        ),
        Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: getEstadiaPacienteHomePage()),
        //child: const EstadiaPacienteHomePage()),
      ][currentPageIndex],
    );
  }

  Widget getPacienteHomePage() {
    context
        .read<PacienteHomeBloc>()
        .add(PacienteHomeRefreshEvent());
    return const PacienteHomePage();
  }

  Widget getEstadiaPacienteHomePage() {
    context
        .read<EstadiaPacienteHomeBloc>()
        .add(EstadiaPacienteHomeRefreshEvent());
    return const EstadiaPacienteHomePage();
  }
}

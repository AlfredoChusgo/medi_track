import 'package:flutter/material.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/estadia_paciente.dart';

import '../../pacienteHome/view/paciente_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
                  'Administracion',                
                ),
        ),
      bottomNavigationBar: const NavigationExample(),),
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
            icon: Icon(Icons.explore),
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
          child: const PacienteHomePage(),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const EstadiaPacienteHomePage()
        ),
      ][currentPageIndex],
    );
  }
}
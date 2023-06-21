import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../paciente/view/paciente_home_page.dart';
import '../../pacienteHome/view/paciente_home_page.dart';
import '../home.dart';

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
        // body: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
                
        //         const SizedBox(height: 20),
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             ElevatedButton(
        //               onPressed: () {
        //                 // Add your button 1 logic here
        //               Navigator.pushNamed(context, '/pacienteHome');
        //             },
        //               child: const Text('Pacientes'),
        //             ),
        //             const SizedBox(width: 10),
        //             ElevatedButton(
        //               onPressed: () {
        //                 // Add your button 2 logic here
        //                 //Navigator.pushNamed(context, '/pacienteAdd');
        //               },
        //               child: const Text('Estadias Paciente'),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
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
          child: const Text('Page 2'),
        ),
      ][currentPageIndex],
    );
  }
}
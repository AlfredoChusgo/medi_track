import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/paciente/bloc/paciente_home_bloc.dart';

import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
                'Administracion',                
              ),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add your button 1 logic here
                    Navigator.pushNamed(context, '/pacienteHome');
                  },
                    child: const Text('Pacientes'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button 2 logic here
                    },
                    child: const Text('Estadias Paciente'),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
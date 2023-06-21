import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/pacienteAdd/paciente_add.dart';

import '../../pacienteHome/paciente.dart';

class ContactoEmergenciaPage extends StatelessWidget {
  const ContactoEmergenciaPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Contacto Emergencia'),
      ),
      body: ContactoEmergenciaAddForm(model: ContactoEmergencia.empty));
  }
}

class ContactoEmergenciaAddForm extends StatelessWidget {
  final ContactoEmergencia model;
  final TextEditingController _idController = TextEditingController();
  late final TextEditingController _nombreController;
  late final TextEditingController _relacionFamiliarController;
  late final TextEditingController _apellidoPaternoController;
  late final TextEditingController _apellidoMaternoController;
  late final TextEditingController _telefonoController;
  late final TextEditingController _direccionController;

  ContactoEmergenciaAddForm({required this.model,super.key}) {
    _nombreController = TextEditingController(text: model.nombre);
    _relacionFamiliarController = TextEditingController(text:model.relacionFamiliar);
    _apellidoPaternoController =
        TextEditingController(text: model.apellidoPaterno);
    _apellidoMaternoController =
        TextEditingController(text: model.apellidoMaterno);
    _telefonoController =
        TextEditingController(text: model.telefono.toString());
    _direccionController =
        TextEditingController(text: model.direccion);
  }

  @override
  Widget build(BuildContext context) {
    final PacienteAddBloc _pacienteFormBloc =
        BlocProvider.of<PacienteAddBloc>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Informacion del paciente",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _apellidoPaternoController,
              decoration: const InputDecoration(labelText: 'Apellido Paterno'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _apellidoMaternoController,
              decoration: const InputDecoration(labelText: 'Apellido Materno'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _relacionFamiliarController,
          
              decoration: const InputDecoration(labelText: 'Relacion Familiar'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              //initialValue: state.telefonoCelular.toString(),
              controller: _telefonoController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Telefono Celular',
              ),
            ),
      
            const SizedBox(height: 16.0),
            TextFormField(
              //initialValue: state.direccionResidencia,
              controller: _direccionController,
              decoration:
                  const InputDecoration(labelText: 'Direccion de residencia'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                ContactoEmergencia contactoEmergencia = ContactoEmergencia.empty.copyWith(
                  relacionFamiliar: _relacionFamiliarController.text, 
                  nombre:_nombreController.text, 
                  apellidoMaterno:_apellidoMaternoController.text, 
                  apellidoPaterno: _apellidoPaternoController.text, 
                  telefono: int.parse(_telefonoController.text), 
                  direccion: _direccionController.text);
                _pacienteFormBloc.add(ContactoEmergenciaAdded(contactoEmergencia));
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

}


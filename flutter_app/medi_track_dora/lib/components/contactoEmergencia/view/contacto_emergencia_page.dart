import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/paciente.dart';

class ContactoEmergenciaPage extends StatelessWidget {
  final ContactoEmergencia model;
  final String saveButtonText;
  final void Function(ContactoEmergencia contactoEmergencia) callback;
  const ContactoEmergenciaPage(
      {super.key,
      required this.model,
      required this.saveButtonText,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulario Contacto Emergencia'),
        ),
        body: ContactoEmergenciaForm(
          model: model,
          saveButtonText: saveButtonText,
          callback: callback,
        ));
  }
}

class ContactoEmergenciaForm extends StatefulWidget {
  final ContactoEmergencia model;
  final String saveButtonText;

  final void Function(ContactoEmergencia contactoEmergencia) callback;
  const ContactoEmergenciaForm(
      {super.key, required this.model,
      required this.saveButtonText,
      required this.callback});

  @override
  _ContactoEmergenciaFormState createState() => _ContactoEmergenciaFormState();
}

class _ContactoEmergenciaFormState extends State<ContactoEmergenciaForm> {
  late final TextEditingController _nombreController;
  late final TextEditingController _relacionFamiliarController;
  late final TextEditingController _apellidoPaternoController;
  late final TextEditingController _apellidoMaternoController;
  late final TextEditingController _telefonoController;
  late final TextEditingController _direccionController;
  late bool isResponsable;
  _ContactoEmergenciaFormState() {}

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.model.nombre);
    _relacionFamiliarController =
        TextEditingController(text: widget.model.relacionFamiliar);
    _apellidoPaternoController =
        TextEditingController(text: widget.model.apellidoPaterno);
    _apellidoMaternoController =
        TextEditingController(text: widget.model.apellidoMaterno);
    _telefonoController =
        TextEditingController(text: widget.model.telefono.toString());
    _direccionController = TextEditingController(text: widget.model.direccion);
    isResponsable = widget.model.isResponsable;
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Text(
                  "Responsable",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Switch(
                    value: isResponsable,
                    onChanged: (value) {
                      setState(() {
                        isResponsable = value;
                      });
                    }),
              ],
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
                ContactoEmergencia contactoEmergencia =
                    ContactoEmergencia.empty().copyWith(
                        id: widget.model.id,
                        relacionFamiliar: _relacionFamiliarController.text,
                        nombre: _nombreController.text,
                        apellidoMaterno: _apellidoMaternoController.text,
                        apellidoPaterno: _apellidoPaternoController.text,
                        telefono: int.parse(_telefonoController.text),
                        direccion: _direccionController.text,
                        isResponsable: isResponsable);
                //
                widget.callback(contactoEmergencia);
                //_pacienteFormBloc.add(ContactoEmergenciaAdded(contactoEmergencia));
                //Navigator.pop(context);
              },
              child: Text(widget.saveButtonText),
            ),
          ],
        ),
      ),
    );
  }
}

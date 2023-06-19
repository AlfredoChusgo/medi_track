import 'package:flutter/material.dart';

import '../../pacienteHome/paciente.dart';



class PacienteDetailPage extends StatelessWidget {
  final Paciente data;

  const PacienteDetailPage({required this.data});

  Widget buildLabel(BuildContext context, String text) {
    return Text(
      text,
      //style: TextStyle(fontWeight: FontWeight.bold),
      style: Theme.of(context).textTheme.titleSmall
    );
  }

    Widget buildText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del paciente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabel(context,'ID:'),
              buildText(context,data.id),
              buildLabel(context,'CI:'),
              buildText(context,data.ci),
              buildLabel(context,'Nombre:'),
              buildText(context,data.nombre),
              buildLabel(context,'Apellido Paterno:'),
              buildText(context,data.apellidoPaterno),
              buildLabel(context,'Apellido Materno:'),
              buildText(context,data.apellidoMaterno),
              buildLabel(context,'Fecha de Nacimiento:'),
              buildText(context,data.fechaNacimiento.toString()),
              buildLabel(context,'Sexo:'),
              buildText(context,data.sexo.toString()),
              buildLabel(context,'Ocupación:'),
              buildText(context,data.ocupacion),
              buildLabel(context,'Procedencia:'),
              buildText(context,data.procedencia),
              buildLabel(context,'Teléfono Celular:'),
              buildText(context,data.telefonoCelular.toString()),
              buildLabel(context,'Teléfono Fijo:'),
              buildText(context,data.telefonoFijo.toString()),
              buildLabel(context,'Dirección de Residencia:'),
              buildText(context,data.direccionResidencia),
              buildLabel(context,'Contacto de Emergencia:'),
              for (var contacto in data.contactoEmergencia)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel(context,'Nombre:'),
                    buildText(context,contacto.nombre),
                    buildLabel(context,'Apellido paterno:'),
                    buildText(context,contacto.apellidoPaterno),
                    buildLabel(context,'Apellido Materno:'),
                    buildText(context,contacto.apellidoMaterno),
                    buildLabel(context,'Parentesco:'),
                    buildText(context,contacto.relacionFamiliar),
                    buildLabel(context,'Teléfono:'),
                    buildText(context,contacto.telefono.toString()),
                    buildLabel(context,'Direccion:'),
                    buildText(context,contacto.direccion),
                    SizedBox(height: 8),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
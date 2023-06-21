import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medi_track_dora/components/pacienteAdd/paciente_add.dart';

import '../../pacienteHome/in_memory_paciente_repository.dart';
import '../../pacienteHome/paciente.dart';

class PacienteAddPage extends StatelessWidget {
  const PacienteAddPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Nuevo Paciente'),
      ),
      body: BlocBuilder<PacienteAddBloc, PacienteAddState>(
        builder: (context, state) {
          if (state is PacienteAddFormState) {
            return PacienteAddForm(state: state);
          }
          if (state is ErrorDuringSaved) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  state.errorMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            );
          }

          if (state is PacienteSavedSuccessfully) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            });
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}

class PacienteAddForm extends StatelessWidget {
  final PacienteAddFormState state;

  final TextEditingController _idController = TextEditingController();
  late final TextEditingController _ciController;
  late final TextEditingController _nombreController;
  late final TextEditingController _apellidoPaternoController;
  late final TextEditingController _apellidoMaternoController;
  late final TextEditingController _fechaNacimientoController;
  late final TextEditingController _sexoController;
  late final TextEditingController _ocupacionController;
  late final TextEditingController _procedenciaController;
  late final TextEditingController _telefonoCelularController;
  late final TextEditingController _telefonoFijoController;
  late final TextEditingController _direccionResidenciaController;

  PacienteAddForm({required this.state, super.key}) {
    //_idController = TextEditingController();
    _ciController = TextEditingController(text: state.ci);
    _nombreController = TextEditingController();
    //_nombreController.set
    _apellidoPaternoController =
        TextEditingController(text: state.apellidoPaterno);
    _apellidoMaternoController =
        TextEditingController(text: state.apellidoMaterno);
    _fechaNacimientoController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(state.fechaNacimiento));
    _sexoController = TextEditingController(text: state.sexo.toString());
    _ocupacionController = TextEditingController(text: state.ocupacion);
    _procedenciaController = TextEditingController(text: state.procedencia);
    _telefonoCelularController =
        TextEditingController(text: state.telefonoCelular.toString());
    _telefonoFijoController =
        TextEditingController(text: state.telefonoFijo.toString());
    _direccionResidenciaController =
        TextEditingController(text: state.direccionResidencia);
    print('called');
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
              //controller: _ciController,
              initialValue: state.ci,
              onChanged: (value) {
                _pacienteFormBloc.add(CIChanged(value));
              },
              decoration:
                  const InputDecoration(labelText: 'Carnet de identidad'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              //controller: _nombreController,
              initialValue: state.nombre,
              onChanged: (value) {
                _pacienteFormBloc.add(NombreChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.apellidoPaterno,
              onChanged: (value) {
                _pacienteFormBloc.add(ApellidoPaternoChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Apellido Paterno'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.apellidoMaterno,
              onChanged: (value) {
                _pacienteFormBloc.add(ApellidoMaternoChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Apellido Materno'),
            ),
            const SizedBox(height: 16.0),
            _SexoDropdownButton(),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _fechaNacimientoController,
              onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now())
                  .then((value) {
                return _pacienteFormBloc
                    .add(FechaNacimientoChanged(value ?? DateTime.now()));
              }),
              decoration:
                  const InputDecoration(labelText: 'Fecha de nacimiento'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.ocupacion,
              onChanged: (value) {
                _pacienteFormBloc.add(OcupacionChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Ocupacion'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.procedencia,
              onChanged: (value) {
                _pacienteFormBloc.add(ProcedenciaChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Procedencia'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.telefonoCelular.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => _pacienteFormBloc
                  .add(TelefonoCelularChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Telefono Celular',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.telefonoFijo.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => _pacienteFormBloc
                  .add(TelefonoFijoChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Telefono Fijo',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.direccionResidencia,
              onChanged: (value) {
                _pacienteFormBloc.add(DireccionResidenciaChanged(value));
              },
              decoration:
                  const InputDecoration(labelText: 'Direccion de residencia'),
            ),
            const SizedBox(height: 16.0),
            Row(children: [
              Text(
                "Contactos de emergencia",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton.filledTonal(
                onPressed: () =>
                    {Navigator.pushNamed(context, '/contactoEmergenciaAdd')},
                icon: Icon(Icons.add),
                color: Theme.of(context).primaryColor,
                //backgroundColor:Colors.blueAccent,
                //highlightColor: Colors.blueAccent,
              ),
            ]),
            ...BuildContactosEmergencia(state.contactosEmergencia, context),
            const SizedBox(height: 16.0),
            ElevatedButton(
              //width: double.infinity,
              onPressed: () {
                _pacienteFormBloc.add(const PacienteSubmit());
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildKeyValueProperty(
      String key, String value, BuildContext context) {
    return [
      const SizedBox(height: 16.0),
      Text('${key.toUpperCase()} : ',
          style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
      Expanded(
        child: Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
      ),
    ];
  }

  List<Widget> BuildContactosEmergencia(
      List<ContactoEmergencia> contactosEmergencia, BuildContext context) {
    List<Widget> widgets = contactosEmergencia
        .map((e) => Column(
              children: [
                Row(
                  children: [
                    ...buildKeyValueProperty('Nombre ', e.nombre, context)
                  ],
                ),
                Row(children: [
                  ...buildKeyValueProperty(
                      'apellido Paterno ', e.apellidoPaterno, context)
                ]),
                Row(children: [
                  ...buildKeyValueProperty(
                      'apellido Materno ', e.apellidoMaterno, context)
                ]),
                Row(
                  children: [
                    ...buildKeyValueProperty(
                        'relacion familiar ', e.relacionFamiliar, context)
                  ],
                ),
                Row(
                  children: [
                    ...buildKeyValueProperty('direccion ', e.direccion, context)
                  ],
                ),
                Row(
                  children: [
                    ...buildKeyValueProperty(
                        'telefono ', e.telefono.toString(), context)
                  ],
                )
              ],
            ))
        .toList();
    // var card = Card(
    //   child: ListTile(
    //     title: Text('Card Title'),
    //     subtitle: Text('Card Subtitle'),
    //     trailing: Row(children: [...widgets]),
    //     trailing: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         IconButton(
    //           icon: Icon(Icons.edit),
    //           onPressed: () {
    //             // Edit button onPressed callback
    //             // Perform edit action here
    //           },
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.delete),
    //           onPressed: () {
    //             // Delete button onPressed callback
    //             // Perform delete action here
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return widgets;
  }
}

class _SexoDropdownButton extends StatefulWidget {
  const _SexoDropdownButton();

  @override
  _SexoDropdownButtonState createState() => _SexoDropdownButtonState();
}

class _SexoDropdownButtonState extends State<_SexoDropdownButton> {
  Sexo? sexoSelected;

  @override
  Widget build(BuildContext context) {
    final PacienteAddBloc _pacienteFormBloc =
        BlocProvider.of<PacienteAddBloc>(context);

    sexoSelected ??= (_pacienteFormBloc.state as PacienteAddFormState).sexo;

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Sexo"),
          DropdownButton<Sexo>(
            key: const Key('newCarForm_brand_dropdownButton'),
            items: Sexo.values.map((Sexo sexo) {
              return DropdownMenuItem<Sexo>(
                value: sexo,
                child: Text(sexo.toString().split('.').last),
              );
            }).toList(),
            value: sexoSelected,
            hint: const Text('Seleccione Sexo'),
            onChanged: (sexo) {
              setState(() {
                sexoSelected = sexo;
              });
              _pacienteFormBloc.add(SexoChanged(sexoSelected!));
            },
          ),
        ],
      ),
    );
  }
}

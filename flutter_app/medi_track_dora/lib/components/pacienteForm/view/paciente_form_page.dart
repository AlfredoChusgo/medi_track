import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../contactoEmergencia/view/contacto_emergencia_page.dart';
import '../../../models/paciente.dart';
import '../bloc/paciente_form_bloc.dart';

class PacienteFormPage extends StatelessWidget {
  final String saveButtonText;
  final void Function() callback;
  const PacienteFormPage(
      {super.key, required this.saveButtonText, required this.callback});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Nuevo Paciente'),
      ),
      body: BlocListener<PacienteFormBloc, PacienteFormState>(
        listener: (context, state) {
          if (state is PacienteActionResponse) {
            String? message = state.message;

            if (state.shouldPop) {
              //Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            }

            Flushbar(
              duration: const Duration(seconds: 3),
              title: "Accion",
              message: message,
            ).show(Navigator.of(context).context);
          }
        },
        child: BlocBuilder<PacienteFormBloc, PacienteFormState>(
          builder: (context, state) {
            if (state is PacienteAddFormState) {
              return PacienteAddForm(
                  state: state,
                  saveButtonText: saveButtonText,
                  callback: callback,
                  readOnly: state.readOnly);
            }
            //Navigator.pop(context);
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class PacienteAddForm extends StatelessWidget {
  final PacienteAddFormState state;
  final String saveButtonText;
  final void Function() callback;
  final bool readOnly;
  late final TextEditingController _fechaNacimientoController;

  PacienteAddForm(
      {required this.state,
      required this.saveButtonText,
      required this.callback,
      required this.readOnly,
      super.key}) {
    _fechaNacimientoController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(state.fechaNacimiento));
  }

  @override
  Widget build(BuildContext context) {
    final PacienteFormBloc pacienteFormBloc =
        BlocProvider.of<PacienteFormBloc>(context);

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
              readOnly: readOnly,
              initialValue: state.ci,
              onChanged: (value) {
                pacienteFormBloc.add(CIChanged(value));
              },
              decoration:
                  const InputDecoration(labelText: 'Carnet de identidad'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.numeroHistoriaClinica.toString(),
              readOnly: readOnly,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => pacienteFormBloc
                  .add(NumeroHistoriaClinicaChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Numero de Historia Clinica',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              //controller: _nombreController,
              readOnly: readOnly,
              initialValue: state.nombre,
              onChanged: (value) {
                pacienteFormBloc.add(NombreChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.apellidoPaterno,
              readOnly: readOnly,
              onChanged: (value) {
                pacienteFormBloc.add(ApellidoPaternoChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Apellido Paterno'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.apellidoMaterno,
              readOnly: readOnly,
              onChanged: (value) {
                pacienteFormBloc.add(ApellidoMaternoChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Apellido Materno'),
            ),
            const SizedBox(height: 16.0),
            const _SexoDropdownButton(),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: true,
              controller: _fechaNacimientoController,
              onTap: () {
                if (!readOnly) {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) {
                    pacienteFormBloc
                        .add(FechaNacimientoChanged(value ?? DateTime.now()));
                  });
                }
              },
              decoration:
                  const InputDecoration(labelText: 'Fecha de nacimiento'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.ocupacion,
              readOnly: readOnly,
              onChanged: (value) {
                pacienteFormBloc.add(OcupacionChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Ocupacion'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.procedencia,
              readOnly: readOnly,
              onChanged: (value) {
                pacienteFormBloc.add(ProcedenciaChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Procedencia'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.telefonoCelular.toString(),
              readOnly: readOnly,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => pacienteFormBloc
                  .add(TelefonoCelularChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Telefono Celular',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.telefonoFijo.toString(),
              readOnly: readOnly,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => pacienteFormBloc
                  .add(TelefonoFijoChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Telefono Fijo',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.direccionResidencia,
              readOnly: readOnly,
              onChanged: (value) {
                pacienteFormBloc.add(DireccionResidenciaChanged(value));
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
              if (!readOnly)
                IconButton.filledTonal(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/contactoEmergenciaAdd')},
                  icon: Icon(Icons.add),
                  color: Theme.of(context).primaryColor,
                ),
            ]),
            ListView.builder(
              shrinkWrap: true,
              itemCount: state
                  .contactosEmergencia.length, // Number of items in the list
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ContactoEmergenciaListItem(
                    state.contactosEmergencia[index], readOnly);
              },
            ),
            const SizedBox(height: 16.0),
            if (!readOnly)
              ElevatedButton(
                //width: double.infinity,
                onPressed: () {
                  //_pacienteFormBloc.add(const PacientePerformSave());
                  callback();
                },
                child: Text(saveButtonText),
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

  List<Widget> buildContactosEmergencia(
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
    final PacienteFormBloc _pacienteFormBloc =
        BlocProvider.of<PacienteFormBloc>(context);

    sexoSelected ??= (_pacienteFormBloc.state as PacienteAddFormState).sexo;

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Sexo"),
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

class ContactoEmergenciaListItem extends StatefulWidget {
  final ContactoEmergencia item;
  final bool readOnly;

  const ContactoEmergenciaListItem(this.item, this.readOnly, {super.key});
  @override
  ContactoEmergenciaListItemState createState() =>
      ContactoEmergenciaListItemState();
}

class ContactoEmergenciaListItemState
    extends State<ContactoEmergenciaListItem> {
  //
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final subTitle =
        '${widget.item.nombre} ${widget.item.apellidoPaterno} ${widget.item.apellidoMaterno}';
    // final subTitle =
    //     '${widget.item.sexo.toString()} ${widget.item.direccionResidencia} ';
    return ExpansionTile(
      leading: const Icon(Icons.person),
      //title: Text(title, style: textTheme),
      title: Text(widget.item.relacionFamiliar),
      collapsedTextColor: Colors.black,
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
      //trailing: const Icon(Icons.menu),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      children: [
        if (_isExpanded)
          Column(
            children: [
              Row(
                children: [
                  ...buildKeyValueProperty(
                      'Nombre ', widget.item.nombre, context)
                ],
              ),
              Row(children: [
                ...buildKeyValueProperty(
                    'apellido Paterno ', widget.item.apellidoPaterno, context)
              ]),
              Row(children: [
                ...buildKeyValueProperty(
                    'apellido Materno ', widget.item.apellidoMaterno, context)
              ]),
              Row(
                children: [
                  ...buildKeyValueProperty('relacion familiar ',
                      widget.item.relacionFamiliar, context)
                ],
              ),
              Row(
                children: [
                  ...buildKeyValueProperty(
                      'direccion ', widget.item.direccion, context)
                ],
              ),
              Row(
                children: [
                  ...buildKeyValueProperty(
                      'telefono ', widget.item.telefono.toString(), context)
                ],
              )
            ],
          ),
        if (!widget.readOnly)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonBar(
                children: [
                  IconButton(
                    color: widget.item.isResponsable ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                    isSelected: widget.item.isResponsable,
                    onPressed: () {
                      context.read<PacienteFormBloc>().add(ContactosEmergenciaUpdated(widget.item.copyWith(isResponsable: !widget.item.isResponsable)));
                    },
                    icon: const Icon(Icons.family_restroom),
                  )
                ],
              ),
              ButtonBar(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ContactoEmergenciaPage(
                              model: widget.item,
                              saveButtonText: "Actualizar",
                              callback: (contactoEmergencia) {
                                BlocProvider.of<PacienteFormBloc>(context).add(
                                    ContactosEmergenciaUpdated(contactoEmergencia));
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<PacienteFormBloc>(context)
                          .add(ContactosEmergenciaDeleted(widget.item.id));
                      // Handle remove button press
                    },
                    icon: const Icon(Icons.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
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
}

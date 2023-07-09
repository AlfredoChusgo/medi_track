import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medi_track_dora/models/valueObjects/date_time_value_object.dart';

import '../../../models/estadia_paciente_model.dart';
import '../estadia_paciente.dart';

class EstadiaPacienteFormPage extends StatelessWidget {
  final String saveButtonText;
  final void Function(EstadiaPaciente estadiaPaciente) callback;

  const EstadiaPacienteFormPage(
      {super.key, required this.saveButtonText, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulario Estadia Paciente'),
        ),
        body: BlocListener<EstadiaPacienteFormBloc, EstadiaPacienteFormState>(
          listener: (context, state) {
            if (state is EstadiaPacientedError) {
              String message = state.message;

              Flushbar(
                duration: const Duration(seconds: 2),
                title: "Accion",
                message: message,
              ).show(context);
            }
            if (state is EstadiaPacienteAddedSuccessfully ||
                state is EstadiaPacienteUpdatedSuccessfully ||
                state is EstadiaPacienteDeletedSuccessfully) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<EstadiaPacienteFormBloc, EstadiaPacienteFormState>(
            builder: (context, state) {
              return switch (state) {
                EstadiaPacienteFormLoadingState() =>
                  const Center(child: CircularProgressIndicator()),
                EstadiaPacienteFormDataState() => EstadiaPacienteForm(
                    state: state,
                    saveButtonText: saveButtonText,
                    callback: callback,
                  ),
                _ => const Center(child: CircularProgressIndicator()),
              };
            },
          ),
        ));
  }
}

class EstadiaPacienteForm extends StatefulWidget {
  final EstadiaPacienteFormDataState state;
  final String saveButtonText;
  final void Function(EstadiaPaciente contactoEmergencia) callback;

  const EstadiaPacienteForm(
      {required this.state,
      super.key,
      required this.saveButtonText,
      required this.callback});

  @override
  State<EstadiaPacienteForm> createState() => _EstadiaPacienteFormState();
}

class _EstadiaPacienteFormState extends State<EstadiaPacienteForm> {
  late final TextEditingController accionesRealizadasController;
  late final TextEditingController fechaIngresoController;
  late final TextEditingController observacionesController;
  late final TextEditingController fechaEgresoController;
  late final TextEditingController diagnosticoController;
  late final TextEditingController tipoServicioController;
  late bool isFechaEgresoEnabled;

  _EstadiaPacienteFormState();
  @override
  void initState() {
    fechaIngresoController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(widget.state.fechaIngreso));
    fechaEgresoController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(widget.state.fechaEgreso.value));
    accionesRealizadasController =
        TextEditingController(text: widget.state.accionesRealizadas);
    observacionesController =
        TextEditingController(text: widget.state.observaciones);
    diagnosticoController =
        TextEditingController(text: widget.state.diagnostico);
    tipoServicioController =
        TextEditingController(text: widget.state.tipoServicio.name);
      isFechaEgresoEnabled = widget.state.fechaEgreso.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Estadia",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: true,
              controller:
                  TextEditingController(text: widget.state.paciente.fullName),
              decoration: const InputDecoration(labelText: 'Paciente'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: true,
              controller: fechaIngresoController,
              onTap: () => {
                if (!widget.state.readOnly)
                  {
                    showDatePicker(
                            context: context,
                            initialDate:
                                getFechaInDateTime(fechaIngresoController.text),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now())
                        .then((value) {
                      setState(() {
                        fechaIngresoController.text = DateFormat('dd-MM-yyyy')
                            .format(value ?? DateTime.now());
                      });
                    })
                  }
              },
              decoration: const InputDecoration(labelText: 'Fecha ingreso'),
            ),
            const SizedBox(height: 16.0),
            ...getFechaEgresoWidget(),
            // TextFormField(
            //   readOnly: true,
            //   controller: fechaEgresoController,
            //   onTap: () => {
            //     if (!widget.state.readOnly)
            //       {
            //         showDatePicker(
            //                 context: context,
            //                 initialDate:
            //                     getFechaInDateTime(fechaEgresoController.text),
            //                 firstDate: DateTime(1900),
            //                 lastDate: DateTime.now())
            //             .then((value) {
            //           fechaEgresoController.text = DateFormat('dd-MM-yyyy')
            //               .format(value ?? DateTime.now());
            //         })
            //       }
            //   },
            //   decoration: const InputDecoration(labelText: 'Fecha Egreso'),
            // ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.state.readOnly,
              minLines: 1,
              maxLines: 2,
              controller: accionesRealizadasController,
              decoration:
                  const InputDecoration(labelText: 'Acciones Realizadas'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.state.readOnly,
              minLines: 1,
              maxLines: 2,
              controller: observacionesController,
              decoration: const InputDecoration(labelText: 'Observaciones'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: widget.state.readOnly,
              minLines: 1,
              maxLines: 2,
              controller: diagnosticoController,
              decoration: const InputDecoration(labelText: 'Diagnostico'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              readOnly: true,
              controller: tipoServicioController,
              onTap: () => {
                if (!widget.state.readOnly)
                  {
                    showServicioDialog(context, (selectedValue) {
                      setState(() {
                        tipoServicioController.text = selectedValue;
                      });
                    })
                  }
              },
              decoration: const InputDecoration(labelText: 'Servicio'),
            ),
            const SizedBox(height: 16.0),
            if (!widget.state.readOnly)
              ElevatedButton(
                onPressed: () {
                  var fechaEgreso = DateTimeValueObject(
                      isEnabled: isFechaEgresoEnabled,
                      value: getFechaInDateTime(fechaEgresoController.text));

                  EstadiaPaciente estadiaPaciente = EstadiaPaciente.empty()
                      .copyWith(
                          id: widget.state.id,
                          paciente: widget.state.paciente,
                          fechaIngreso:
                              getFechaInDateTime(fechaIngresoController.text),
                          fechaEgreso: fechaEgreso,
                          accionesRealizadas: accionesRealizadasController.text,
                          observaciones: observacionesController.text,
                          diagnostico: diagnosticoController.text,
                          tipoServicio: TipoServicio.values
                              .where(
                                  (e) => e.name == tipoServicioController.text)
                              .first);
                  widget.callback(estadiaPaciente);
                },
                child: Text(widget.saveButtonText),
              ),
          ],
        ),
      ),
    );
  }

  DateTime getFechaInDateTime(text) {
    return DateFormat('dd-MM-yyyy').parse(text);
  }

  void showServicioDialog(
      BuildContext context, Function(String selectedOption) fn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ...TipoServicio.values.map((value) {
                  return SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, value);
                      fn(value.name);
                    },
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    ).then((selectedOption) {
      // Handle the selected option
    });
  }

  List<Widget> getFechaEgresoWidget() {
    return [
      ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 1,
        expansionCallback: (panelIndex, isExpanded) {
          // context.read<EstadiaPacienteFilterBloc>().add(!isExpanded
          //     ? EnableFechaFilterEvent()
          //     : DisableFechaFilterEvent());
          isFechaEgresoEnabled = true;
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SwitchListTile(
                  title: const Text('Fecha Egreso'),
                  value: isFechaEgresoEnabled,
                  onChanged: (value) {
                    // context.read<EstadiaPacienteFilterBloc>().add(value
                    //     ? EnableFechaFilterEvent()
                    //     : DisableFechaFilterEvent());
                    setState(() {
                      isFechaEgresoEnabled = value;
                    });
                  },
                ),
              );
            },
            body: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  controller: fechaEgresoController,
                  onTap: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) {
                    // context.read<EstadiaPacienteFilterBloc>().add(
                    //     SelectFechaIngresoInicioEvent(
                    //         fechaIngresoInicio: value ?? DateTime.now()));
                    fechaEgresoController.text = DateFormat('dd-MM-yyyy')
                        .format(value ?? DateTime.now());
                  }),
                  decoration: const InputDecoration(labelText: 'Fecha egreso'),
                ),
              ],
            ),
            isExpanded: isFechaEgresoEnabled,
          ),
        ],
      ),
    ];
  }
}

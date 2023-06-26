import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/estadia_paciente.dart';

import '../estadia_paciente_filter.dart';

class EstadiaPacienteFilterPage {
  static void openBottomSheet(BuildContext context, Function callback) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<EstadiaPacienteFilterBloc,
                      EstadiaPacienteFilterState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            "Seleccionar filtros ",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          ...getPacientesFilter(state, context),
                          const SizedBox(height: 16.0),
                          ...getFechaFilterWidget(
                              context,
                              state.fechaIngresoInicio,
                              state.fechaIngresoFin,
                              state.fechaFilterEnabled),
                          const SizedBox(height: 16.0),
                          ...getServicioFilterWidget(state, context),
                          ElevatedButton(
                            onPressed: () {
                              // Add your button onPressed logic here
                              callback(state.toEstadiaPacienteFilter());
                              Navigator.of(context).pop();
                            },
                            child: const Text('Aplicar filtros'),
                          ),
                        ],
                      );
                    },
                  )),
            ),
          ),
        );
      },
    );
  }

  static List<Widget> getSearchPacienteWidgets(
      EstadiaPacienteFilterState state, BuildContext context) {
    return [
      const SizedBox(height: 16.0),
      TextFormField(
        initialValue: "",
        onChanged: (value) {},
        onFieldSubmitted: (value) {
          context
              .read<EstadiaPacienteFilterBloc>()
              .add(SearchPacienteByNameEvent(name: value));
        },
        decoration: const InputDecoration(labelText: 'Buscar paciente'),
      ),
      const SizedBox(height: 16.0),
      state.pacienteList.fold(
          (l) => Center(
                child: Text(l),
              ),
          (r) => SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: r.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          "${r[index].nombre} ${r[index].apellidoPaterno} ${r[index].apellidoMaterno}"),
                      onTap: () {
                        context.read<EstadiaPacienteFilterBloc>().add(
                            SelectPacienteFromListevent(paciente: r[index]));
                      },
                    );
                  },
                ),
              ))
    ];
  }

  static List<Widget> getFechaFilterWidget(BuildContext context,
      DateTime fechaIngresoInicio, DateTime fechaEgresoInicio, bool enabled) {
    return [
      ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 1,
        expansionCallback: (panelIndex, isExpanded) {
          context.read<EstadiaPacienteFilterBloc>().add(!isExpanded
              ? EnableFechaFilterEvent()
              : DisableFechaFilterEvent());
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SwitchListTile(
                  title: const Text('Filtrar por fecha'),
                  value: enabled,
                  onChanged: (value) {
                    context.read<EstadiaPacienteFilterBloc>().add(value
                        ? EnableFechaFilterEvent()
                        : DisableFechaFilterEvent());
                  },
                ),
              );
            },
            body: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: DateFormat('dd-MM-yyyy').format(fechaEgresoInicio)),
                  onTap: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) {
                    context.read<EstadiaPacienteFilterBloc>().add(
                        SelectFechaIngresoInicioEvent(
                            fechaIngresoInicio: value ?? DateTime.now()));
                  }),
                  decoration:
                      const InputDecoration(labelText: 'Fecha ingreso inicio'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: DateFormat('dd-MM-yyyy').format(fechaEgresoInicio)),
                  onTap: () => showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) {
                    context.read<EstadiaPacienteFilterBloc>().add(
                        SelectFechaIngresoFinEvent(
                            fechaIngresoFin: value ?? DateTime.now()));
                  }),
                  decoration:
                      const InputDecoration(labelText: 'Fecha ingreso fin'),
                )
              ],
            ),
            isExpanded: enabled,
          ),
        ],
      ),
    ];
  }

  static List<Widget> getServicioFilterWidget(
      EstadiaPacienteFilterState state, BuildContext context) {
    return [
      ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 1,
        expansionCallback: (panelIndex, isExpanded) {
          context.read<EstadiaPacienteFilterBloc>().add(!isExpanded
              ? EnableServicioFilterEvent()
              : DisableServicioFilterEvent());
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SwitchListTile(
                  title: const Text('Filtrar por servicio'),
                  value: state.servicioFilterEnabled,
                  onChanged: (value) {
                    context.read<EstadiaPacienteFilterBloc>().add(value
                        ? EnableServicioFilterEvent()
                        : DisableServicioFilterEvent());
                  },
                ),
              );
            },
            body: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  //initialValue: state.tipoServicio.toString(),
                  controller: TextEditingController(
                      text: state.tipoServicio.toString()),
                  onTap: () => showServicioDialog(context),
                  decoration: const InputDecoration(labelText: 'Servicio'),
                ),
              ],
            ),
            isExpanded: state.servicioFilterEnabled,
          ),
        ],
      ),
    ];
  }

  static List<Widget> getPacientesFilter(
      EstadiaPacienteFilterState state, BuildContext context) {
    return [
      ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 1,
        expansionCallback: (panelIndex, isExpanded) {
          context.read<EstadiaPacienteFilterBloc>().add(!isExpanded
              ? EnablePacienteFilterEvent()
              : DisablePacienteFilterEvent());
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SwitchListTile(
                  title: const Text('Filtrar por paciente'),
                  value: state.pacienteFilterEnabled,
                  onChanged: (value) {
                    context.read<EstadiaPacienteFilterBloc>().add(value
                        ? EnablePacienteFilterEvent()
                        : DisablePacienteFilterEvent());
                  },
                ),
              );
            },
            body: Column(
              children: [
                if (state.paciente.isLeft())
                  ...getSearchPacienteWidgets(state, context)
                else if (state.paciente.isRight())
                  getPacienteSelectedWidget(state, context),
              ],
            ),
            isExpanded: state.pacienteFilterEnabled,
          ),
        ],
      ),
    ];
  }

  static Widget getPacienteSelectedWidget(
      EstadiaPacienteFilterState state, BuildContext context) {
    return TextFormField(
      controller: TextEditingController(
          text:
              state.paciente.fold((l) => "Sin Seleccionar", (r) => r.fullName)),
      readOnly: true,
      //initialValue: state.paciente.fold((l) => "Sin Seleccionar", (r) => r.fullName),
      onChanged: (value) {
        //_pacienteFormBloc.add(CIChanged(value));
      },
      onFieldSubmitted: (value) {
        context
            .read<EstadiaPacienteFilterBloc>()
            .add(SearchPacienteByNameEvent(name: value));
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                context
                    .read<EstadiaPacienteFilterBloc>()
                    .add(UnSelectPacientetevent());
              },
              icon: const Icon(Icons.close)),
          labelText: 'Paciente'),
    );
  }

  static void showServicioDialog(BuildContext context) {
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
      context
          .read<EstadiaPacienteFilterBloc>()
          .add(SelectTipoServicioEvent(tipoServicio: selectedOption));
    });
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/estadia_paciente_filter_model.dart';
import '../../estadiaPacienteFilter/view/estadia_paciente_filter_page.dart';
import '../../estadiaPacienteForm/estadia_paciente.dart';
import '../estadia_paciente.dart';

class EstadiaPacienteHomePage extends StatelessWidget {
  const EstadiaPacienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Estadia Pacientes'),
          actions: [
            IconButton(
                onPressed: () {
                  EstadiaPacienteFilterPage.openBottomSheet(context,
                      (EstadiaPacienteFilter estadiaPacienteFilter) {
                    context.read<EstadiaPacienteHomeBloc>().add(
                        EstadiaPacienteHomeRefreshWithFiltersEvent(
                            filter: estadiaPacienteFilter));
                  });
                },
                icon: const Icon(Icons.filter_alt_sharp))
          ],
          //floating: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child:
              BlocListener<EstadiaPacienteFormBloc, EstadiaPacienteFormState>(
            listener: (listenerContext, state) {
              if (state is EstadiaPacienteAddedSuccessfully ||
                  state is EstadiaPacienteUpdatedSuccessfully ||
                  state is EstadiaPacienteDeletedSuccessfully) {
                String message = (state as dynamic).message;

                Future.delayed(Duration.zero, () {
                  Flushbar(
                    duration: const Duration(seconds: 2),
                    title: "Evento",
                    message: message,
                  ).show(context);
                });

                context
                    .read<EstadiaPacienteHomeBloc>()
                    .add(EstadiaPacienteHomeRefreshEvent());
              }
            },
            child:
                BlocBuilder<EstadiaPacienteHomeBloc, EstadiaPacienteHomeState>(
              builder: (context, state) {
                return switch (state) {
                  EstadiaPacienteHomeLoadingState() => const Expanded(
                      child: Center(child: CircularProgressIndicator())),
                  EstadiaPacienteHomeLoadedState() => Column(children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.estadiaPacientes
                            .length, // Number of items in the list
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return EstadiaPacienteListItem(
                              state.estadiaPacientes[index]);
                        },
                      )
                    ]),
                  EstadiaPacienteHomeErrorState() => Text(state.errorMessage),
                  EstadiaPacienteEmptyListState() => Expanded(
                      child: Center(
                          child: Text('Sin nada \nque mostrar.... \u{1F644}',
                              style:
                                  Theme.of(context).textTheme.headlineMedium)))
                };
              },
            ),
          ),
        ),
      );
    });
  }
}

class EstadiaPacienteListItem extends StatefulWidget {
  final EstadiaPaciente item;
  const EstadiaPacienteListItem(this.item, {super.key});
  @override
  EstadiaPacienteListItemState createState() => EstadiaPacienteListItemState();
}

class EstadiaPacienteListItemState extends State<EstadiaPacienteListItem> {
  //
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleMedium;
    final title = widget.item.paciente.fullName;
    final subTitle =
        '${widget.item.tipoServicioReadable} ${DateFormat('dd-MM-yyyy').format(widget.item.fechaIngreso)} ';
    return ExpansionTile(
      leading: const Icon(Icons.medical_information),
      title: Text(title, style: textTheme),
      collapsedTextColor: Colors.black,
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
      //trailing: const Icon(Icons.menu),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      children: [
        // ListTile(
        //   title: Text('Item Details'),
        // ),
        if (_isExpanded)
          ButtonBar(
            children: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<EstadiaPacienteFormBloc>(context).add(
                      ReadEstadiaPacienteFormEvent(
                          estadiaPaciente: widget.item));
                  Navigator.pushNamed(context, '/estadiaPacienteDetail');
                },
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<EstadiaPacienteFormBloc>(context).add(
                      EditEstadiaPacienteFormEvent(
                          estadiaPaciente: widget.item));
                  Navigator.pushNamed(context, '/estadiaPacienteEdit');
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context.read<EstadiaPacienteHomeBloc>().add(DeleteEstadiaPacienteEvent(id:widget.item.id));
                  // BlocProvider.of<EstadiaPacienteFormBloc>(context)
                  //     .add(DeleteEstadiaPacienteFormEvent(id: widget.item.id));
                },
                icon: const Icon(Icons.delete),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

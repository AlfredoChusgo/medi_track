import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/estadia_paciente_filter_model.dart';
import '../../estadiaPacienteFilter/view/estadia_paciente_filter_page.dart';
import '../estadia_paciente.dart';

class EstadiaPacienteHomePage extends StatelessWidget {
  const EstadiaPacienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read<EstadiaPacienteHomeBloc>().add(EstadiaPacienteHomeRefreshEvent());
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
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
          child: Column(children: [
            BlocBuilder<EstadiaPacienteHomeBloc, EstadiaPacienteHomeState>(
              builder: (context, state) {
                return switch (state) {
                  EstadiaPacienteHomeLoadingState() => const CircularProgressIndicator(),
                  EstadiaPacienteHomeLoadedState() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.estadiaPacientes
                          .length, // Number of items in the list
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return EstadiaPacienteListItem(
                            state.estadiaPacientes[index]);
                      },
                    ),
                  EstadiaPacienteHomeErrorState() =>
                    Text(state.errorMessage)
                };
              },
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // FAB onPressed action
            // BlocProvider.of<PacienteAddBloc>(context)
            //     .add(const PacienteAddNewEvent());
            // Navigator.pushNamed(context, '/pacienteAdd');
          },
          child: const Icon(Icons.add),
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
    final subTitle = '${widget.item.tipoServicioReadable} ';
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
                  // Handle edit button press
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         PacienteDetailPage(data: widget.item),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () {
                  // BlocProvider.of<PacienteAddBloc>(context)
                  //     .add(PacienteEditEvent(widget.item));
                  // Navigator.pushNamed(context, '/pacienteEdit');
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  // Handle remove button press
                  // BlocProvider.of<PacienteAddBloc>(context)
                  //     .add(PacientePerformDelete(id: widget.item.id));
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

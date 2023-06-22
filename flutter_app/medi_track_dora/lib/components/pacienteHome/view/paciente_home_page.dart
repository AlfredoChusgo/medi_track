import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/pacienteHome/bloc/paciente_home_bloc.dart';

import '../../pacienteAdd/bloc/paciente_add_bloc.dart';
import '../../pacienteDetail/view/paciente_detail_page.dart';
import '../paciente.dart';

class PacienteHomePage extends StatelessWidget {
  const PacienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        //floating: true,
      ),
      body: CustomScrollView(
        slivers: [
          //const CatalogAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<PacienteHomeBloc, PacienteHomeState>(
            builder: (context, state) {
              return switch (state) {
                PacienteHomeLoadingState() => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                PacienteHomeErrorState() => SliverFillRemaining(
                    child: Text(state.errorMessage),
                  ),
                PacienteHomeLoadedState() => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => PacienteListItem(
                        state.pacientes[index],
                      ),
                      childCount: state.pacientes.length,
                    ),
                  )
              };
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // FAB onPressed action
          BlocProvider.of<PacienteAddBloc>(context)
              .add(const PacienteAddNewEvent());
          Navigator.pushNamed(context, '/pacienteAdd');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class PacienteListItem extends StatefulWidget {
  final Paciente item;
  const PacienteListItem(this.item, {super.key});
  @override
  PacienteListItemState createState() => PacienteListItemState();
}

class PacienteListItemState extends State<PacienteListItem> {
  //
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleMedium;
    final title =
        '${widget.item.nombre} ${widget.item.apellidoPaterno} ${widget.item.apellidoMaterno}';
    final subTitle =
        '${widget.item.sexo.toString()} ${widget.item.direccionResidencia} ';
    return ExpansionTile(
      leading: const Icon(Icons.person),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PacienteDetailPage(data: widget.item),
                    ),
                  );
                },
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<PacienteAddBloc>(context)
                      .add(PacienteEditEvent(widget.item));
                  Navigator.pushNamed(context, '/pacienteEdit');
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
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
    );
  }
}

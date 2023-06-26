import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/estadiaPacienteFilter/bloc/estadia_paciente_filter_bloc.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/bloc/estadia_paciente_home_bloc.dart';
import 'package:medi_track_dora/components/pacienteHome/bloc/paciente_home_bloc.dart';

import '../../../models/estadia_paciente_filter_model.dart';
import '../../pacienteAdd/bloc/paciente_add_bloc.dart';
import '../../search_app_bar/view/search_bar_app_bar.dart';
import '../../../models/paciente.dart';

class PacienteHomePage extends StatelessWidget {
  const PacienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarAppBar(
        barTitle: "Pacientes",
        searchTextCallback: (searchText) {
          context
              .read<PacienteHomeBloc>()
              .add(PacienteHomeRefreshWithFilterEvent(name: searchText));
        },
        defaultStateCallback: () {
          context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
        },
      ),
      body: CustomScrollView(
        slivers: [
          //const CatalogAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocListener<PacienteAddBloc, PacienteAddState>(
            listener: (context, state) {
              if (state is PacienteActionResponse) {
                String? message = state.message;
                if (state.shouldPop) {
                  context
                      .read<PacienteHomeBloc>()
                      .add(PacienteHomeRefreshEvent());
                }
                Flushbar(
                  duration: const Duration(seconds: 3),
                  title: "Accion",
                  message: message,
                ).show(Navigator.of(context).context);
              }
            },
            child: BlocBuilder<PacienteHomeBloc, PacienteHomeState>(
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
                    ),
                  PacienteHomeEmptyList() => SliverFillRemaining(
                      child: Center(
                          child: Text('Sin nada \nque mostrar.... \u{1F644}',
                              style:
                                  Theme.of(context).textTheme.headlineMedium)))
                };
              },
            ),
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
    var backgroundColor =
        widget.item.sexo == Sexo.masculino ? Colors.blue : Colors.pink;
    return ExpansionTile(
      backgroundColor: backgroundColor[200],
      collapsedBackgroundColor: backgroundColor[100],
      collapsedIconColor: backgroundColor[300],
      iconColor: backgroundColor[400],

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonBar(
              children: [
                IconButton(
                  onPressed: () {
                    EstadiaPacienteFilter filter =
                        EstadiaPacienteFilter.empty();

                    context.read<EstadiaPacienteHomeBloc>().add(
                        EstadiaPacienteHomeRefreshWithFiltersEvent(
                            filter: filter.copyWith(
                                paciente: widget.item,
                                pacienteFilterEnabled: true)));
                    context.read<EstadiaPacienteFilterBloc>().add(
                        SelectPacienteFromListevent(paciente: widget.item));
                    context
                        .read<EstadiaPacienteFilterBloc>()
                        .add(EnablePacienteFilterEvent());

                    Navigator.pushNamed(context, '/estadiaPacienteFiltered');
                  },
                  icon: const Icon(Icons.history),
                ),
                                  IconButton(
                  onPressed: () {
                    //todo

                  },
                  icon: const Icon(Icons.add),
                ),
              ],
              ),
              ButtonBar(
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<PacienteAddBloc>(context).add(
                          PacienteDetailsInReadOnlyEvent(
                              paciente: widget.item));
                      Navigator.pushNamed(context, '/pacienteDetails');
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
                      BlocProvider.of<PacienteAddBloc>(context)
                          .add(PacientePerformDelete(id: widget.item.id));
                    },
                    icon: const Icon(Icons.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          )
      ],
    );
  }
}

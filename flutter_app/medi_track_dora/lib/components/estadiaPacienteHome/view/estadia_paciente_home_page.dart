import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../estadia_paciente.dart';


class EstadiaPacienteHomePage extends StatelessWidget {
  const EstadiaPacienteHomePage({super.key});

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
          BlocBuilder<EstadiaPacienteHomeBloc, EstadiaPacienteHomeState>(
            builder: (context, state) {
              return switch (state) {
                EstadiaPacienteHomeLoadingState() => const Center(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                EstadiaPacienteHomeErrorState() => SliverFillRemaining(
                    child: Text(state.errorMessage),
                  ),
                EstadiaPacienteHomeLoadedState() => 
                CircularProgressIndicator()
                // SliverList(
                //     delegate: SliverChildBuilderDelegate(
                //       (context, index) => PacienteListItem(
                //         state.estadiaPacientes[index],
                //       ),
                //       childCount: state.estadiaPacientes.length,
                //     ),
                //   )
              };
            },
          ),
        ],
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
  }
}

// class EstadiaPacienteListItem extends StatefulWidget {
//   final EstadiaPaciente item;
//   const EstadiaPacienteListItem(this.item, {super.key});
//   @override
//   PacienteListItemState createState() => PacienteListItemState();
// }

// class PacienteListItemState extends State<EstadiaPacienteListItem> {
//   //
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme.titleMedium;
//     final title =
//         '${widget.item.nombre} ${widget.item.apellidoPaterno} ${widget.item.apellidoMaterno}';
//     final subTitle =
//         '${widget.item.sexo.toString()} ${widget.item.direccionResidencia} ';
//     return ExpansionTile(
//       leading: const Icon(Icons.person),
//       title: Text(title, style: textTheme),
//       collapsedTextColor: Colors.black,
//       subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
//       //trailing: const Icon(Icons.menu),
//       onExpansionChanged: (value) {
//         setState(() {
//           _isExpanded = value;
//         });
//       },
//       children: [
//         // ListTile(
//         //   title: Text('Item Details'),
//         // ),
//         if (_isExpanded)
//           ButtonBar(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   // Handle edit button press
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           PacienteDetailPage(data: widget.item),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.info),
//               ),
//               IconButton(
//                 onPressed: () {
//                   BlocProvider.of<PacienteAddBloc>(context)
//                       .add(PacienteEditEvent(widget.item));
//                   Navigator.pushNamed(context, '/pacienteEdit');
//                 },
//                 icon: const Icon(Icons.edit),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Handle remove button press
//                   BlocProvider.of<PacienteAddBloc>(context)
//                       .add(PacientePerformDelete(id: widget.item.id));
//                 },
//                 icon: const Icon(Icons.delete),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }

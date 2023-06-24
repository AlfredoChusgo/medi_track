import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../estadiaPacienteFilter/view/estadia_paciente_filter_page.dart';
import '../estadia_paciente.dart';

class EstadiaPacienteHomePage extends StatelessWidget {
  const EstadiaPacienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Estadia Pacientes'),
          //floating: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(children: [
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) => ListTile(
            //       title: Text('Item $index'),
            //     ),
            //     childCount: 20,
            //   ),
            // ),
            BlocBuilder<EstadiaPacienteHomeBloc, EstadiaPacienteHomeState>(
              builder: (context, state) {
                return switch(state){
                  EstadiaPacienteHomeLoadingState()=> const CircularProgressIndicator(),
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
                EstadiaPacienteHomeErrorState() => Text(state.errorMessage ?? 'Something')
                };
              },
            )
            //const CatalogAppBar(),
            // const SliverToBoxAdapter(child: SizedBox(height: 12)),
            // BlocBuilder<EstadiaPacienteHomeBloc, EstadiaPacienteHomeState>(
            //   builder: (context, state) {
            //     return switch (state) {
            //       EstadiaPacienteHomeLoadingState() => const Center(
            //           child: Center(child: CircularProgressIndicator()),
            //         ),
            //       EstadiaPacienteHomeErrorState() => SliverFillRemaining(
            //           child: Text(state.errorMessage),
            //         ),
            //       EstadiaPacienteHomeLoadedState() =>
            //       CircularProgressIndicator()
            //       // SliverList(
            //       //     delegate: SliverChildBuilderDelegate(
            //       //       (context, index) => PacienteListItem(
            //       //         state.estadiaPacientes[index],
            //       //       ),
            //       //       childCount: state.estadiaPacientes.length,
            //       //     ),
            //       //   )
            //     };
            //   },
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // FAB onPressed action
            // BlocProvider.of<PacienteAddBloc>(context)
            //     .add(const PacienteAddNewEvent());
            // Navigator.pushNamed(context, '/pacienteAdd');
            EstadiaPacienteFilterPage.openBottomSheet(context, () {});
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

// class EstadiaPacienteHomePage extends StatefulWidget {
//   @override
//   _EstadiaPacienteHomePageState createState() => _EstadiaPacienteHomePageState();
// }

// class _EstadiaPacienteHomePageState extends State<EstadiaPacienteHomePage> {
//   ScrollController _scrollController = ScrollController();
//   bool _isAppBarCollapsed = false;

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _toggleAppBar() {
//     setState(() {
//       _isAppBarCollapsed = !_isAppBarCollapsed;
//       if (_isAppBarCollapsed) {
//         _scrollController.animateTo(
//           0,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.ease,
//         );
//       } else {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.ease,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Collapsing App Bar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: CustomScrollView(
//           controller: _scrollController,
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 200,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text('Collapsing App Bar'),
//                 background: Container(
//                   color: Colors.blue,
//                 ),
//               ),
//               floating: true,
//               pinned: true,
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) => ListTile(
//                   title: Text('Item $index'),
//                 ),
//                 childCount: 20,
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _toggleAppBar,
//           child: Icon(Icons.arrow_upward),
//         ),
//       ),
//     );
//   }
// }

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
    final subTitle = 'servicio: ${widget.item.tipoServicioReadable} ';
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

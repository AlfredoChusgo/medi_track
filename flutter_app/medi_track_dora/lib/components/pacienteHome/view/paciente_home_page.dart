import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/pacienteHome/bloc/paciente_home_bloc.dart';

import '../../pacienteDetail/view/paciente_detail_page.dart';
import '../paciente.dart';

class PacienteHomePage extends StatelessWidget {
  const PacienteHomePage({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CatalogAppBar(),
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
          Navigator.pushNamed(context, '/pacienteAdd');
        },
        child: Icon(Icons.add),
      ),);
  }
}

// class AddButton extends StatelessWidget {
//   const AddButton({required this.item, super.key});

//   final Item item;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return BlocBuilder<CartBloc, CartState>(
//       builder: (context, state) {
//         return switch (state) {
//           CartLoading() => const CircularProgressIndicator(),
//           CartError() => const Text('Something went wrong!'),
//           CartLoaded() => Builder(
//               builder: (context) {
//                 final isInCart = state.cart.items.contains(item);
//                 return TextButton(
//                   style: TextButton.styleFrom(
//                     disabledForegroundColor: theme.primaryColor,
//                   ),
//                   onPressed: isInCart
//                       ? null
//                       : () => context.read<CartBloc>().add(CartItemAdded(item)),
//                   child: isInCart
//                       ? const Icon(Icons.check, semanticLabel: 'ADDED')
//                       : const Text('ADD'),
//                 );
//               },
//             )
//         };
//       },
//     );
//   }
// }

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Pacientes'),
      floating: true,
      
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.shopping_cart),
      //     onPressed: () => Navigator.of(context).pushNamed('/cart'),
      //   ),
      // ],
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
                      builder: (context) => PacienteDetailPage(data: widget.item),
                    ),
                  );
                },
                icon: const Icon(Icons.info),
              ),
              IconButton(
                onPressed: () {
                  // Handle edit button press
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
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   child: LimitedBox(
    //     maxHeight: 48,
    //     child: Row(
    //       children: [
    //         AspectRatio(aspectRatio: 1, child: ColoredBox(color: Theme.of(context).primaryColor)),
    //         const SizedBox(width: 24),
    //         Expanded(child: Text(item.nombre, style: textTheme)),
    //         const SizedBox(width: 24),
    //         //AddButton(item: item),
    //       ],
    //     ),
    //   ),
    // );
  }
}

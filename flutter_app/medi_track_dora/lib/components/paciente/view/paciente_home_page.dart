import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/paciente/bloc/paciente_home_bloc.dart';

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
    );
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
      title: const Text('Paciente Home'),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.of(context).pushNamed('/cart'),
        ),
      ],
    );
  }
}

class PacienteListItem extends StatelessWidget {
  const PacienteListItem(this.item, {super.key});

  final Paciente item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(aspectRatio: 1, child: ColoredBox(color: Theme.of(context).primaryColor)),
            const SizedBox(width: 24),
            Expanded(child: Text(item.nombre, style: textTheme)),
            const SizedBox(width: 24),
            //AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
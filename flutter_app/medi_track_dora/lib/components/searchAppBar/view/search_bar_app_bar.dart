import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/settings/settings.dart';

import '../bloc/search_bar_bloc.dart';

class SearchBarAppBar extends StatelessWidget implements PreferredSizeWidget {
  late final TextEditingController textController;
  final String barTitle;
  final void Function(String searchText) searchTextCallback;
  final void Function() defaultStateCallback;

  SearchBarAppBar(
      {required this.searchTextCallback,
      required this.defaultStateCallback,
      required this.barTitle,
      super.key}) {
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBarBloc, SearchBarState>(
      listener: (context, state) {
        if (state is DisplaySearchBarState) {
          textController.text = state.text;
        }
      },
      child: BlocBuilder<SearchBarBloc, SearchBarState>(
        //buildWhen: (previous, current) => current is! SearchBarTextChangedState,
        builder: (context, state) {
          return switch (state) {
            HideSearchBarState() => AppBar(
                title: Text(barTitle),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<SearchBarBloc>().add(SearchActivated());
                      },
                      icon: const Icon(Icons.search))
                ],
                //floating: true,
              ),
            DisplaySearchBarState() => AppBar(
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          IconButton(
                              color: Theme.of(context).primaryColorDark,
                              onPressed: () {
                                context
                                    .read<SearchBarBloc>()
                                    .add(BackArrowActivated());
                                defaultStateCallback();
                              },
                              icon: const Icon(Icons.arrow_back_sharp)),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller: textController,
                                      onFieldSubmitted: (value) {
                                        searchTextCallback(value);
                                      }))),
                          IconButton(
                              color: Theme.of(context).primaryColorDark,
                              onPressed: () {
                                textController.text = "";
                              },
                              icon: const Icon(Icons.close))
                        ],
                      )),
                ),
                centerTitle: true,
              ),
            PerformSearchState() => CircularProgressIndicator(),
          };
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

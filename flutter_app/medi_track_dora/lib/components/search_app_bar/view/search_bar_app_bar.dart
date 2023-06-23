import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bar_bloc.dart';

class SearchBarAppBar extends StatelessWidget implements PreferredSizeWidget {
  late TextEditingController textController;
  final String barTitle;
  final void Function(String searchText) searchTextCallback;
  
  SearchBarAppBar({required this.searchTextCallback,required this.barTitle,super.key}){
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<SearchBarBloc, SearchBarState>(
      listener: (context, state) {
        if(state is DisplaySearchBarState){
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

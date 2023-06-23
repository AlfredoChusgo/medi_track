import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_bar_event.dart';
part 'search_bar_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBarBloc() : super(HideSearchBarState()) {
    on<SearchActivated>(_OnSearchActivated);
    on<BackArrowActivated>(_OnBackArrowActivated);
    on<PerformSearchAction>(_OnPerformSearchAction);
    on<CloseActivated>(_OnCloseActivated);
    on<SearchTextChanged>(_OnSearchTextChanged);
  }

  FutureOr<void> _OnSearchActivated(SearchActivated event, Emitter<SearchBarState> emit) {
    emit(DisplaySearchBarState.empty());
  }

  FutureOr<void> _OnBackArrowActivated(BackArrowActivated event, Emitter<SearchBarState> emit) {
    emit(HideSearchBarState());
  }

  FutureOr<void> _OnPerformSearchAction(PerformSearchAction event, Emitter<SearchBarState> emit) {
    emit(PerformSearchState(text: event.text));
  }

  FutureOr<void> _OnCloseActivated(CloseActivated event, Emitter<SearchBarState> emit) async {
    emit(DisplaySearchBarState.empty());
  }

  FutureOr<void> _OnSearchTextChanged(SearchTextChanged event, Emitter<SearchBarState> emit) {
    emit(SearchBarTextChangedState(text: event.text));
  }
}

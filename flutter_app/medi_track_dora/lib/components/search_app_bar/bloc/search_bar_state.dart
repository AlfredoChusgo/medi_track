part of 'search_bar_bloc.dart';

sealed class SearchBarState extends Equatable {}

class HideSearchBarState extends SearchBarState {
  @override
  List<Object?> get props => [];
}
class DisplaySearchBarState extends SearchBarState {
  final String text;
  final bool dirty;
  DisplaySearchBarState({required this.text, required this.dirty});
  factory DisplaySearchBarState.empty(){
    return DisplaySearchBarState(text: "", dirty: false);
  }
  @override
  List<Object?> get props => [text,dirty];
}

class PerformSearchState extends SearchBarState {
  final String text;
  
  PerformSearchState({required this.text});
  @override
  List<Object?> get props => [text];
}

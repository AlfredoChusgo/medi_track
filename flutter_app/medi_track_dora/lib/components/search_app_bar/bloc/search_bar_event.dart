part of 'search_bar_bloc.dart';


sealed class SearchBarEvent extends Equatable{}

class SearchActivated extends  SearchBarEvent {

  @override  
  List<Object?> get props => [];
}

class SearchTextChanged extends  SearchBarEvent {
    final String text;

  SearchTextChanged({required this.text});
  @override  
  List<Object?> get props => [text];
}


class BackArrowActivated extends  SearchBarEvent {
  @override  
  List<Object?> get props => [];
}

class CloseActivated extends  SearchBarEvent {
  @override  
  List<Object?> get props => [];
}

class PerformSearchAction extends  SearchBarEvent {
  final String text;

  PerformSearchAction({required this.text});

  @override  
  List<Object?> get props => throw UnimplementedError();
}


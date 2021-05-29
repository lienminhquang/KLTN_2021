import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchTextChangedEvent extends SearchEvent {
  final String searchText;
  SearchTextChangedEvent(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

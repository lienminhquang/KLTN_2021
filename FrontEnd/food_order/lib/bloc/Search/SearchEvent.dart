import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchTextChangedEvent extends SearchEvent {
  final String searchText;
  final List<int>? cid;
  SearchTextChangedEvent(this.searchText, this.cid);

  @override
  List<Object?> get props => [searchText];
}

import 'package:flutter/cupertino.dart';

@immutable
abstract class CategoryEvent {}

class CategoryStatedEvent extends CategoryEvent {
  final int categoryID;
  CategoryStatedEvent(this.categoryID);
}

import 'package:equatable/equatable.dart';

abstract class PromotionEvent {}

class PromotionStartedEvent extends PromotionEvent {}

class PromotionRefreshEvent extends PromotionEvent {}

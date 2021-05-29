import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Category/CategoryEvent.dart';
import 'package:food_delivery/bloc/Category/CategoryState.dart';
import 'package:food_delivery/services/CategoriesServices.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoadingState());
  final CategoriesServices _categoriesServices = CategoriesServices();
  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryStatedEvent) {
      yield* _mapStartedEventToState(event);
      // } else if (event is CartDeletedEvent) {
      //   yield* _mapDeletedEventToState(event, state);
      // } else if (event is CartCreatedEvent) {
      //   yield* _mapCreatedEventToState(event, state);
      // } else if (event is CartConfirmEvent) {
      //   yield* _mapConfirmEventToState(event, state);
      // } else if (event is CartSetAddressEvent) {
      //   yield* _mapSetAddressEventToState(event, state);
    }
  }

  Stream<CategoryState> _mapStartedEventToState(
      CategoryStatedEvent event) async* {
    yield CategoryLoadingState();
    try {
      yield await _fetchAll(event);
    } catch (e) {
      print(e);
      yield CategoryErrorState("Error");
    }
  }

  Future<CategoryState> _fetchAll(CategoryStatedEvent event) async {
    //items.clear();
    var result = await _categoriesServices.getFoodsInCategory(event.categoryID);
    var category = await _categoriesServices.getByID(event.categoryID);
    if (result.isSuccessed != true) {
      return CategoryErrorState(result.errorMessage!);
    }
    if (category.isSuccessed == false) {
      return CategoryErrorState(category.errorMessage!);
    }
    return CategoryLoadedState(result.payLoad!.items!, category.payLoad!);
  }
}

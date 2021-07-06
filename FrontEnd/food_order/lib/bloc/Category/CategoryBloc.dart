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
    }
  }

  Stream<CategoryState> _mapStartedEventToState(
      CategoryStatedEvent event) async* {
    yield CategoryLoadingState();

    yield await _fetchAll(event);
  }

  Future<CategoryState> _fetchAll(CategoryStatedEvent event) async {
    //items.clear();
    var allFood =
        await _categoriesServices.getFoodsInCategory(event.categoryID);
    var bestSelling = await _categoriesServices
        .getBestSellingFoodsInCategory(event.categoryID);
    var promoting =
        await _categoriesServices.getPromotingFoodsInCategory(event.categoryID);
    var category = await _categoriesServices.getByID(event.categoryID);
    if (allFood.isSuccessed != true) {
      return CategoryErrorState(allFood.errorMessage!);
    }
    if (category.isSuccessed == false) {
      return CategoryErrorState(category.errorMessage!);
    }
    return CategoryLoadedState(
        allFood.payLoad!.items!,
        bestSelling.payLoad!.items!,
        promoting.payLoad!.items!,
        category.payLoad!);
  }
}

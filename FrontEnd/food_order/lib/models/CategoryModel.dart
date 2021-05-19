import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/CategoriesServices.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class CategoryModel extends ChangeNotifier {
  List<CategoryVM> items = [];
  final CategoriesServices _categoriesServices = CategoriesServices();
  Map<int, List<FoodVM>> map = {};
  late int currentID;

  Future<void> fetchAll() async {
    //items.clear();
    var result = await _categoriesServices.getAllPaging();
    if (result.isSuccessed == true) {
      items = (result.payLoad!.items!);
    }
    notifyListeners();
  }

  Future<void> fetchFoodsInCategory(int id) async {
    currentID = id;
    map.remove(id);
    var result = await _categoriesServices.getFoodsInCategory(id);
    if (result.isSuccessed == true) {
      map[id] = result.payLoad!.items!;
    }
    notifyListeners();
  }
}

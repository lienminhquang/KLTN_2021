import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/services/CategoriesServices.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class CategoryModel extends ChangeNotifier {
  final List<CategoryVM> _items = [];
  final CategoriesServices _categoriesServices = CategoriesServices();
  final Map<int, List<FoodVM>> _map = {};

  UnmodifiableListView<CategoryVM> get items => UnmodifiableListView(_items);
  UnmodifiableMapView<int, List<FoodVM>> get maps => UnmodifiableMapView(_map);

  Future<void> fetchAll() async {
    _items.clear();
    var result = await _categoriesServices.getAllPaging();
    if (result.isSuccessed == true) {
      _items.addAll(result.payLoad!.items!);
    }
    notifyListeners();
  }

  Future<void> fetchFoodsInCategory(int id) async {
    _map.remove(id);
    var result = await _categoriesServices.getFoodsInCategory(id);
    if (result.isSuccessed == true) {
      _map[id] = result.payLoad!.items!;
    }
    notifyListeners();
  }
}

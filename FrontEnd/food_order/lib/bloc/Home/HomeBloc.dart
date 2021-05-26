import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Home/HomeState.dart';
import 'package:food_delivery/services/CategoriesServices.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState());
  final CategoriesServices _categoriesServices = CategoriesServices();
  Stream<HomeState> _mapStartedEventToState(HomeEvent event) async* {
    yield HomeLoadingState();
    try {
      var list = await _fetchAll();
      yield HomeLoadedState(list);
    } catch (e) {
      print(e);
      yield HomeErrorState("Error");
    }
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStartedEvent) {
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

  Future<List<CategoryVM>> _fetchAll() async {
    //items.clear();
    var result = await _categoriesServices.getAllPaging();
    if (result.isSuccessed == true) {
      return (result.payLoad!.items!);
    }
    throw result.errorMessage!;
  }
}

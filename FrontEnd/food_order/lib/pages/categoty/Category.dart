import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Category/CategoryBloc.dart';
import 'package:food_delivery/bloc/Category/CategoryState.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailBloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailEvent.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class CategoryPage extends StatefulWidget {
  static String routeName = "/category";

  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  _CategoryPageState();

  Widget _buildLoadedState(BuildContext context, CategoryLoadedState state) {
    return Scaffold(
      appBar: AppBar(
        title: new Text((state.categoryVM.name == null
            ? "Category"
            : state.categoryVM.name)!),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: _Search(["cau luong", "com cho"]));
              }),
        ],
      ),
      body: Container(
          //color: Colors.grey,
          child: Column(
        children: [BestSelling(state), Expanded(child: AllFood(state))],
      )
          //TODO: [bestSelling] what is this???
          ),
    );
  }

  Widget _buildErrorState(BuildContext context, CategoryErrorState state) {
    return Text(state.error);
  }

  @override
  Widget build(BuildContext context) {
    //log("Context:" + context.hashCode.toString());
    //final categoryID = context.read<CategoryModel>().currentID;
    // var category = context
    //     .select<CategoryModel, List<CategoryVM>>((value) => value.items)
    //     .firstWhere((element) => element.id == categoryID);
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoadingState) {
        return CircularProgressIndicator();
      }
      if (state is CategoryLoadedState) {
        return _buildLoadedState(context, state);
      }
      if (state is CategoryErrorState) {
        return _buildErrorState(context, state);
      }
      throw "Unknow state";
    });
  }
}

class BestSelling extends StatefulWidget {
  final CategoryLoadedState _categoryLoadedState;
  BestSelling(this._categoryLoadedState);
  @override
  _BestSellingState createState() => _BestSellingState(_categoryLoadedState);
}

class _BestSellingState extends State<BestSelling> {
  final CategoryLoadedState _categoryLoadedState;
  _BestSellingState(this._categoryLoadedState);
  @override
  Widget build(BuildContext context) {
    final categoryID = _categoryLoadedState.categoryVM.id;
    log("BestSelling: category: " + categoryID.toString());
    log("Context:" + context.hashCode.toString());

    return Container(
      //padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      height: 150,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Món bán chạy",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 110,
              child: ListView.builder(
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryLoadedState.listFood.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodCard(_categoryLoadedState.listFood[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class AllFood extends StatelessWidget {
  final CategoryLoadedState _categoryLoadedState;
  AllFood(this._categoryLoadedState);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
      child: Column(
        children: [
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "All food",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                //scrollDirection: Axis.vertical,
                itemCount: _categoryLoadedState.listFood.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodCard(_categoryLoadedState.listFood[index]);
                }),
          )
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final FoodVM _foodVM;
  FoodCard(this._foodVM);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () async {
            // context
            //     .read<FoodDetailBloc>()
            //     .add(FoodDetailStartedEvent(_foodVM.id));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FoodDetail(
                          foodID: _foodVM.id,
                          promotionID: null,
                        )));
          },
          child: Container(
            color: Colors.grey[300],
            //margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: Row(
              children: [
                ClipRRect(
                  //borderRadius: BorderRadius.circular(10),
                  child: Container(
                      child: Stack(children: [
                    Container(
                      width: 110,
                      height: 110,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl:
                            AppConfigs.URL_Images + "/${_foodVM.imagePath}",
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: 110,
                        color: Colors.white38,
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            Text(
                              "${_foodVM.agvRating.toStringAsPrecision(2)} (${_foodVM.totalRating})",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    )
                  ])),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 170,
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _foodVM.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppConfigs.AppNumberFormat.format(
                                        _foodVM.price),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        //width: 100,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppConfigs.AppNumberFormat.format(
                                                _foodVM.price),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Search extends SearchDelegate {
  String selectedResult = "";
  final List<String> listExample;
  _Search(this.listExample);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList
            .addAll(listExample.where((element) => element.contains(query)));
    recentList = suggestionList;
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index]),
            onTap: () {
              selectedResult = suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}

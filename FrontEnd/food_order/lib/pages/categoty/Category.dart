import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Category/CategoryBloc.dart';
import 'package:food_delivery/bloc/Category/CategoryState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/food_detail/FoodDetail.dart';
import 'package:food_delivery/pages/home/AppLoadingScreen.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
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
      ),
      body: Container(
          //color: Colors.grey,
          child: Column(
        children: [
          BestSelling(state),
          _PromotingItems(state),
          Expanded(child: AllFood(state))
        ],
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
        return AppLoadingScreen();
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
                  itemCount: _categoryLoadedState.bestSelling.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodCard(
                        foodVM: _categoryLoadedState.bestSelling[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _PromotingItems extends StatelessWidget {
  final CategoryLoadedState _categoryLoadedState;
  _PromotingItems(this._categoryLoadedState);
  @override
  Widget build(BuildContext context) {
    final categoryID = _categoryLoadedState.categoryVM.id;

    if (_categoryLoadedState.promoting.isEmpty) {
      return Container();
    }

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
                "Món đang giảm giá",
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
                  itemCount: _categoryLoadedState.promoting.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodCard(
                        foodVM: _categoryLoadedState.promoting[index]);
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
          // Divider(
          //   thickness: 2,
          // ),
          SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tất cả",
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
                itemCount: _categoryLoadedState.allFood.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodCard(
                    foodVM: _categoryLoadedState.allFood[index],
                    bottomBorder:
                        BorderSide(width: 1.0, color: Colors.grey.shade300),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final FoodVM foodVM;
  FoodCard({required this.foodVM, this.bottomBorder = BorderSide.none});
  final BorderSide bottomBorder;

  Widget _priceWidget(FoodVM foodVM) {
    if (foodVM.saleCampaignVM != null) {
      double discount = foodVM.saleCampaignVM!.percent;
      return Row(
        children: [
          Text(
            AppConfigs.toPrice(foodVM.price * (100 - discount) / 100) + "  ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Text(
            AppConfigs.toPrice(foodVM.price),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey),
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          AppConfigs.toPrice(foodVM.price),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          //top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
          //left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
          // right: BorderSide(width: 1.0, color: Color(0xFF000000)),
          bottom: bottomBorder,
        ),
      ),
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetail(
                        foodID: foodVM.id,
                        promotionID: null,
                      )));
        },
        child: Container(
          //height: 80,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    child: Stack(children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                              color: AppTheme.circleProgressIndicatorColor)),
                      imageUrl: AppConfigs.URL_Images + "/${foodVM.imagePath}",
                    ),
                  ),
                ])),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                //width: 170,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 170,
                      margin: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          foodVM.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    _priceWidget(foodVM),
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          Text(
                            "${foodVM.agvRating.toStringAsPrecision(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          Text(
                            " (${foodVM.totalRating})",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
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

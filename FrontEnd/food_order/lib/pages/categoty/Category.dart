import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/CategoryModel.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  static String routeName = "/category";

  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    log("Context:" + context.hashCode.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: Search(["cau luong", "com cho"]));
              }),
        ],
      ),
      body: Container(
          //color: Colors.grey,
          child: Column(
        children: [BestSelling(), Expanded(child: AllFood())],
      )
          //TODO: [bestSelling] what is this???
          ),
    );
  }
}

class BestSelling extends StatefulWidget {
  @override
  _BestSellingState createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  @override
  Widget build(BuildContext context) {
    final int categoryID = ModalRoute.of(context)!.settings.arguments as int;
    log("BestSelling: category: " + categoryID.toString());
    log("Context:" + context.hashCode.toString());
    var categoryModel = context.watch<CategoryModel>();
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
                  itemCount: categoryModel.maps[categoryID]!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodCard(categoryModel.maps[categoryID]![index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class AllFood extends StatefulWidget {
  @override
  _AllFoodState createState() => _AllFoodState();
}

class _AllFoodState extends State<AllFood> {
  @override
  Widget build(BuildContext context) {
    final int categoryID = ModalRoute.of(context)!.settings.arguments as int;
    var categoryModel = context.watch<CategoryModel>();
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0.0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
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
                itemCount: categoryModel.maps[categoryID]!.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodCard(categoryModel.maps[categoryID]![index]);
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
    return Container(
      color: Colors.grey[300],
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: Row(
        children: [
          Container(
              child: Stack(children: [
            Container(
              width: 110,
              height: 110,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: AppConfigs.URL_Images + "/${_foodVM.imagePath}",
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
                      "4.5 (999+)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
              ),
            )
          ])),
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
                              _foodVM.price.toString(),
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
                                      _foodVM.price.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                //Expanded(child: Container()),
                                //Spacer(),
                                IconButton(
                                    icon: Icon(Icons.add_circle,
                                        size: 30, color: Colors.red),
                                    onPressed: () {})
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
    );
  }
}

class Search extends SearchDelegate {
  String selectedResult = "";
  final List<String> listExample;
  Search(this.listExample);

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

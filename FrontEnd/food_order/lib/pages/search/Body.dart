import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Search/SearchBloc.dart';
import 'package:food_delivery/bloc/Search/SearchEvent.dart';
import 'package:food_delivery/bloc/Search/SearchState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/categoty/Category.dart';
import 'package:food_delivery/pages/food_detail/FoodDetail.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/pages/search/CategoryFilter.dart';
import 'package:food_delivery/pages/search/SortOption.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  @override
  __SearchBodyState createState() => __SearchBodyState();
}

class __SearchBodyState extends State<_SearchBody> {
  final _textController = TextEditingController();
  late SearchBloc _searchBloc;
  SortFactor? _sortFactor = SortFactor.Name;
  List<int>? cid;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = "";
    _searchBloc.add(SearchTextChangedEvent("", null));
  }

  Widget _searchBar() {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _searchBloc.add(SearchTextChangedEvent(text, cid));
      },
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.search),
          suffixIcon: GestureDetector(
            child: Icon(Icons.clear),
            onTap: () {
              _onClearTapped();
            },
          ),
          border: InputBorder.none,
          hintText: 'Bạn muốn ăn gì?'),
    );
  }

  Widget _searchEmptyState() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appBarBackground,
          title: _searchBar(),
        ),
        body: Center(
          child: Text("Không tìm thấy món nào phù hợp"),
        ));
  }

  Widget _searchLoadingState() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appBarBackground,
          title: _searchBar(),
        ),
        body: Center(
          child: CircularProgressIndicator(
              color: AppTheme.circleProgressIndicatorColor),
        ));
  }

  Widget _searchErrorState(SearchErrorState state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appBarBackground,
          title: _searchBar(),
        ),
        body: Text(state.error));
  }

  Widget _searchResultState(SearchSuccessState state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appBarBackground,
          title: _searchBar(),
        ),
        body: _SearchResults(state.listFood, state.listCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchEmptyState) {
          return _searchEmptyState();
        }
        if (state is SearchLoadingState) {
          return _searchLoadingState();
        }
        if (state is SearchErrorState) {
          return _searchErrorState(state);
        }
        if (state is SearchSuccessState) {
          return _searchResultState(state);
        }
        throw "Unknow State";
      }),
    );
  }

  Widget _SearchResults(List<FoodVM> listFood, List<CategoryVM> listCategory) {
    if (_sortFactor == SortFactor.Name) {
      listFood.sort((x, y) {
        return x.name.compareTo(y.name);
      });
    } else if (_sortFactor == SortFactor.Favorite) {
      listFood.sort((x, y) {
        return y.totalRating - x.totalRating;
      });
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    var rs = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SortOption(
                              sortFactor: _sortFactor,
                            )));
                    if (rs != null) {
                      setState(() {
                        _sortFactor = rs as SortFactor?;
                      });
                    }
                  },
                  child: Container(
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Sắp xếp"),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    )),
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Text(
                  "Lọc:",
                  style: TextStyle(color: Colors.grey),
                ),
                InkWell(
                  onTap: () async {
                    var rs = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CategoryFilter(
                        categoryVMs: listCategory,
                        cid: cid,
                      );
                    }));
                    if (rs is List<int>) {
                      cid = rs;
                      _searchBloc.add(
                          SearchTextChangedEvent(_textController.text, cid));
                    }
                  },
                  child: Container(
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Danh mục" +
                            (cid != null ? " (${cid!.length})" : "")),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    )),
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  itemCount: listFood.length,
                  itemBuilder: (context, index) {
                    return FoodCard(foodVM: listFood[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

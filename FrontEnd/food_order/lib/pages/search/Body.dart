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
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // child: Column(
        //   children: [_SearchBar(), _SearchBody()],
        // ),
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarBackground,
        title: _SearchBar(),
        // bottom: PreferredSize(
        //   child: Row(
        //     children: [],
        //   ),
        //   preferredSize: Size.fromHeight(30),
        // ),
      ),
      body: _SearchBody(),
    ));
  }
}

class _SearchBar extends StatefulWidget {
  _SearchBar({Key? key}) : super(key: key);

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late SearchBloc _searchBloc;

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

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _searchBloc.add(SearchTextChangedEvent(text));
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

  void _onClearTapped() {
    _textController.text = "";
    _searchBloc.add(SearchTextChangedEvent(""));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchEmptyState) {
        return Container();
      }
      if (state is SearchLoadingState) {
        return CircularProgressIndicator(
            color: AppTheme.circleProgressIndicatorColor);
      }
      if (state is SearchErrorState) {
        return Text(state.error);
      }
      if (state is SearchSuccessState) {
        return state.listFood.isEmpty
            ? Text("Không tìm thấy kết quả!")
            : _SearchResults(state.listFood);
      }
      throw "Unknow State";
    });
  }
}

class _SearchResults extends StatelessWidget {
  final List<FoodVM> _listFood;
  _SearchResults(this._listFood);
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog();
                      });
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
              Container(
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("Danh mục"), Icon(Icons.keyboard_arrow_down)],
                )),
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            //height: 100,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: _listFood.length,
                itemBuilder: (context, index) {
                  return FoodCard(foodVM: _listFood[index]);
                }),
          ),
        ),
      ],
    );
  }
}

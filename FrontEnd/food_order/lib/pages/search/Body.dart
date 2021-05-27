import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailBloc.dart';
import 'package:food_delivery/bloc/FoodDetail/FoodDetailEvent.dart';
import 'package:food_delivery/bloc/Search/SearchBloc.dart';
import 'package:food_delivery/bloc/Search/SearchEvent.dart';
import 'package:food_delivery/bloc/Search/SearchState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/food_detail/food_detail.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_SearchBar(), _SearchBody()],
      ),
    );
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
          prefixIcon: Icon(Icons.search),
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
        return CircularProgressIndicator();
      }
      if (state is SearchErrorState) {
        return Text(state.error);
      }
      if (state is SearchSuccessState) {
        return state.listFood.isEmpty
            ? Text("Không tìm thấy kết quả!")
            : Expanded(child: _SearchResults(state.listFood));
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
    return Container(
      //height: 100,
      child: ListView.builder(
          itemCount: _listFood.length,
          itemBuilder: (context, index) {
            return _ResultItem(_listFood[index]);
          }),
    );
  }
}

class _ResultItem extends StatelessWidget {
  _ResultItem(this._foodVM);
  final FoodVM _foodVM;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: AppConfigs.URL_Images + "/${_foodVM.imagePath}",
        ),
      ),
      title: Text(_foodVM.name),
      onTap: () {
        context.read<FoodDetailBloc>().add(FoodDetailStartedEvent(_foodVM.id));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return FoodDetail();
        }));
      },
    );
  }
}

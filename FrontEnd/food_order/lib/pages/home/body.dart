import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Cart/CartBloc.dart';
import 'package:food_delivery/bloc/Category/CategoryBloc.dart';
import 'package:food_delivery/bloc/Category/CategoryEvent.dart';
import 'package:food_delivery/bloc/Home/HomeBloc.dart';
import 'package:food_delivery/bloc/Home/HomeEvent.dart';
import 'package:food_delivery/bloc/Home/HomeState.dart';
import 'package:food_delivery/bloc/Promotions/PromotionBloc.dart';
import 'package:food_delivery/bloc/Promotions/PromotionEvent.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/NotificationModel.dart';
import 'package:food_delivery/pages/food_detail/FoodDetail.dart';
import 'package:food_delivery/pages/home/DashlinePainter.dart';
import 'package:food_delivery/pages/home/AppLoadingScreen.dart';
import 'package:food_delivery/pages/home/ZigZacVerticalLine.dart';
import 'package:food_delivery/pages/presentation/Themes.dart';
import 'package:food_delivery/pages/promotion/Promotions.dart';
import 'package:food_delivery/pages/search/Search.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
import 'package:food_delivery/view_models/Foods/FoodVM.dart';
import 'package:food_delivery/view_models/Promotions/PromotionVM.dart';
import 'package:food_delivery/view_models/SaleCampaigns/SaleCampaignVM.dart';
import 'package:provider/provider.dart';

import '../categoty/Category.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> _appBannerImages = [];

  @override
  void initState() {
    _appBannerImages = [
      "images/app_banner/giam_10k.jpeg",
      "images/app_banner/giam_50.jpeg",
      "images/app_banner/khao_50_phan_tram.jpg",
      "images/app_banner/khao_60_phan_tram.png",
      "images/app_banner/sieu_deal_thu_5_chi_1D.jpeg",
    ];
    super.initState();
  }

  Widget buidImageCarousel(List<String> images) {
    return Container(
      height: 150,
      child: CarouselSlider(
        options: CarouselOptions(
          //height: 400.0,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 1.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Image.asset(i)),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoadingState) {
        return AppLoadingScreen();
      }
      if (state is HomeLoadedState) {
        return _buildLoadedState(context, state);
      }
      throw "Unknown state!";
    });
  }

  Widget _buildLoadedState(BuildContext context, HomeLoadedState state) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeRefeshEvent());
          },
          child: ListView(
            children: [
              //NotificationWidget(),
              fakeSearchBox(),
              buidImageCarousel(_appBannerImages),
              offers(state),
              _categoryList(state.listCategory),
              Divider(
                height: 30,
              ),
              SaleContainer(state.listSaleCampaign),
              PromotionContainer(state.listPromotion),
              //PromotionContainer(state.listPromotion[1]),
            ],
          ),
        ),
      ),
    );
  }

  Widget fakeSearchBox() {
    return Container(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Search()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.all(20),
        height: 40,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Icon(
                Icons.search,
                color: Colors.grey[500],
              ),
            ),
            Text(
              "Bạn muốn ăn uống gì nhỉ?",
              style: TextStyle(color: Colors.grey[500], fontSize: 15.0),
            )
          ],
        ),
      ),
    ));
  }

  Widget offers(HomeLoadedState state) {
    if (state.listPromotion.length == 0) {
      return Container(
        height: 20,
      );
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (conetxt) {
          return PromotionScreen();
        }));
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey),
            right: BorderSide.none,
            bottom: BorderSide(color: Colors.grey),
            left: BorderSide(color: Colors.grey),
          ),
          color: Color(0xFFEEEEEE),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nhanh tay nào! Có ${state.listPromotion.length} khuyến mãi đang chờ nè",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Color(0xFF5B5B5B)),
                textAlign: TextAlign.left,
              ),
            ),
            Positioned(
                right: 0,
                child: CustomPaint(
                  size: Size(1, 50),
                  painter: ZigZacVerticalLine(),
                ))
          ],
        ),
      ),
    );
  }

  Widget _categoryList(List<CategoryVM> categories) {
    log("Rebuild CategoryList with count = " + categories.length.toString());

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        //height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(2, (col) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(2, (row) {
                int index = col * 2 + row;
                if (index < categories.length) {
                  return CategoryItem(categories[index].name!,
                      categories[index].imagePath!, categories[index].id!);
                }
                return Container(
                  width: 100,
                  height: 130,
                );
              }),
            );
          }),
        ));
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String image;
  final int id;
  CategoryItem(this.name, this.image, this.id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CategoryBloc>().add(CategoryStatedEvent(id));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CategoryPage();
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: Color(0xFFEEEEEE)),
        width: 150,
        height: 150,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Container(
                width: 126,
                height: 100,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: AppTheme.circleProgressIndicatorColor,
                  )),
                  imageUrl: AppConfigs.URL_Images + "/$image",
                ),
              ),
            ),
            Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
              this.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ))
          ],
        ),
      ),
    );
  }
}

Widget _priceWidget(FoodVM foodVM, SaleCampaignVM? saleCampaignVM) {
  if (saleCampaignVM == null) {
    return Text(
      AppConfigs.toPrice(foodVM.price),
      style: TextStyle(
          fontSize: 14,
          //fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.9)),
    );
  } else
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 14,
              color: Colors.red,
            ),
            Text(
              "${saleCampaignVM.percent.toInt()}% ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              AppConfigs.toPrice(foodVM.price),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.6),
                  decoration: TextDecoration.lineThrough),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Text(
          AppConfigs.toPrice(
              foodVM.price * (100 - saleCampaignVM.percent) / 100),
          style: TextStyle(
              fontSize: 14,
              //fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.9)),
        ),
      ],
    );
}

class _FoodWidget extends StatelessWidget {
  const _FoodWidget(
      {Key? key, required this.foodVM, this.saleCampaignVM, this.promotionVM})
      : super(key: key);
  final FoodVM foodVM;
  final SaleCampaignVM? saleCampaignVM;
  final PromotionVM? promotionVM;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FoodDetail(
                foodID: foodVM.id,
                promotionID: promotionVM != null ? promotionVM!.id : null,
              );
            }));
          },
          child: Container(
            width: 150,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 200,
                  //padding: const EdgeInsets.all(16.0),
                  child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                              color: AppTheme.circleProgressIndicatorColor)),
                      imageUrl: AppConfigs.URL_Images + "/${foodVM.imagePath}",
                      fit: BoxFit.cover),
                ),
                Container(
                  width: 150,
                  height: 45,
                  padding: EdgeInsets.fromLTRB(7, 7, 7, 0),
                  child: Text(
                    foodVM.name,
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  //height: 50,
                  width: 150,
                  child: _priceWidget(foodVM, saleCampaignVM),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PromotionContainer extends StatelessWidget {
  final List<PromotionVM> _listPromotionVM;
  PromotionContainer(this._listPromotionVM);
  @override
  Widget build(BuildContext context) {
    if (_listPromotionVM.length == 0) {
      return Container();
    }
    var _promotionVM = _listPromotionVM[0];
    return Container(
      //color: Colors.grey[50],
      padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 50.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 3.0, 8.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _promotionVM.name.toUpperCase(),
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFFF5166)),
              ),
            ),
          ),
          Container(
            //margin: const EdgeInsets.fromLTRB(20.0, 3.0, 8.0, 3.0),
            child: Align(
              child: Text(
                _promotionVM.desciption!,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF646D7A), fontWeight: FontWeight.w500),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _promotionVM.foodVMs.length,
                itemBuilder: (BuildContext context, int index) {
                  final foodVM = _promotionVM.foodVMs[index];

                  return _FoodWidget(
                    foodVM: foodVM,
                    promotionVM: _promotionVM,
                    saleCampaignVM: foodVM.saleCampaignVM,
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SaleContainer extends StatelessWidget {
  final List<SaleCampaignVM> _listSaleCampaignVM;
  SaleContainer(this._listSaleCampaignVM);
  @override
  Widget build(BuildContext context) {
    if (_listSaleCampaignVM.length > 0) {
      var _saleCampaignVM = _listSaleCampaignVM[0];

      return Container(
        //color: Colors.grey[50],
        padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 50.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 3.0, 8.0, 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _saleCampaignVM.name.toUpperCase(),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFFFF5166)),
                ),
              ),
            ),
            Container(
              //margin: const EdgeInsets.fromLTRB(20.0, 3.0, 8.0, 3.0),
              child: Align(
                child: Text(
                  _saleCampaignVM.desciption,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 250,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _saleCampaignVM.foodVMs!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final foodVM = _saleCampaignVM.foodVMs![index];

                    return _FoodWidget(
                      foodVM: foodVM,
                      promotionVM: null,
                      saleCampaignVM: _saleCampaignVM,
                    );
                  }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

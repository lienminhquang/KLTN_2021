import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/models/CategoryModel.dart';
import 'package:food_delivery/models/NotificationModel.dart';
import 'package:food_delivery/view_models/Categories/CategoryVM.dart';
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
    Widget fakeSearchBox = Container(
        child: GestureDetector(
      onTap: () {
        //TODO: Navigate to real search page
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
              "What are you craving?",
              style: TextStyle(color: Colors.grey[500], fontSize: 15.0),
            )
          ],
        ),
      ),
    ));

    Widget offers = Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green[100],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "There are 100 food rewards waiting.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: Colors.red[400]),
            ),
          ),
          MaterialButton(
            color: Colors.orange[200],
            onPressed: () {},
            child: Text("View"),
          )
        ],
      ),
    );

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            //NotificationWidget(),
            fakeSearchBox,
            buidImageCarousel(_appBannerImages),
            offers,
            _CategoryList(),
            FastChoice(),
            FastChoice()
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories =
        context.select<CategoryModel, List<CategoryVM>>((value) => value.items);
    log("Rebuild CategoryList with count = " + categories.length.toString());

    return Container(
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            //primary: false,
            //padding: const EdgeInsets.all(20),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                // padding: EdgeInsets.all(5),
                // height: 20,
                // width: 20,
                // color: Colors.red,
                //width: 100,
                child: CategoryItem(categories[index].name!,
                    categories[index].imagePath!, categories[index].id!),
              );
            }));
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String image;
  final int id;
  CategoryItem(this.name, this.image, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 4,
          offset: Offset(0, 3),
        )
      ]),
      child: GestureDetector(
        onTap: () async {
          await context.read<CategoryModel>().fetchFoodsInCategory(id);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CategoryPage()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.teal[100],
            ),
            padding: const EdgeInsets.all(0),
            child: Stack(fit: StackFit.expand, children: [
              CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: AppConfigs.URL_Images + "/$image",
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          tileMode: TileMode.clamp,
                          colors: [Colors.grey, Colors.grey.withOpacity(0.3)])),
                  //color: Colors.grey.withOpacity(0.7),
                  child: Center(
                    child: Text(
                      "$name",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class FastChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey[50],
      padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 50.0),
      child: Column(
        children: [
          Container(
            //margin: const EdgeInsets.fromLTRB(20.0, 3.0, 8.0, 3.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Chill Tết Siêu Đã | Giảm 45K",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ),
          Container(
            //margin: const EdgeInsets.fromLTRB(20.0, 3.0, 8.0, 3.0),
            child: Align(
              child: Text("Nhập mã CHILLTET giảm 45K cho đơn từ 100K.",
                  textAlign: TextAlign.left),
              alignment: Alignment.centerLeft,
            ),
          ),
          Container(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        width: 200,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.arrow_drop_down_circle),
                              title: const Text('Card title 1'),
                              subtitle: Text(
                                'Secondary Text',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Perform some action
                                  },
                                  child: const Text('ACTION 1'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Perform some action
                                  },
                                  child: const Text('ACTION 2'),
                                ),
                              ],
                            ),
                            // Image.asset('assets/card-sample-image.jpg'),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<NotificationModel>();
    if (model.unreadedNotification.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(model.unreadedNotification[0].title),
              content: Text(model.unreadedNotification[0].message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text('Ok'),
                ),
              ],
            );
          });
    }
    return Container();
  }
}

import 'package:flutter/material.dart';

import 'Home.dart';

class Promotions extends StatefulWidget {
  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> myTab = [
    Tab(
      text: 'Saved',
    ),
    Tab(
      text: 'Experied Soon',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTab.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _promotionItem = Container(
      child: Card(
        child: ListTile(
          leading: Image.asset('images/crabs.jpg'),
          title: Text("Uu dai len den 50k"),
          subtitle: Text("Tat cac cac don hang"),
          trailing: TextButton(
            onPressed: () {},
            child: Column(
              children: [
                GestureDetector(child: Text("Dung ngay"), onTap: (){
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) {
                  //       return MyHomePage();
                  //     }),
                  //   );
                },),
                Text("HSD: 15.04.2021")
              ],
            ),
          ),
        ),
      ),
    );

    Widget _savedPage = Container(
      child: ListView(
        children: [
          _promotionItem,
          _promotionItem,
          _promotionItem,
          _promotionItem,
          _promotionItem,
          _promotionItem,
        ],
      ),
    );
    Widget _expSoon = Container(
      child: ListView(
        children: [
          _promotionItem,
          _promotionItem,
          _promotionItem,
          _promotionItem,
          _promotionItem,
          _promotionItem,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              child: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
                tabs: myTab,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Container(
              child: Expanded(
                child: TabBarView(
                  children: [_savedPage, _expSoon],
                  controller: _tabController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

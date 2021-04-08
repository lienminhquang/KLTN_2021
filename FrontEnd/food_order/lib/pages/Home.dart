import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget imageCarousel = Container(
    // TODO: Correct auto play animations, click to open details pages
    height: 150,

    child: Carousel(
      autoplay: false,
      images: [
        AssetImage('images/yelloweyecat.jpg'),
        AssetImage('images/cat.jpg'),
        AssetImage('images/ladybug.jpg'),
        AssetImage('images/seals.jpg'),
        AssetImage('images/crabs.jpg'),
        AssetImage('images/animegirl.jpg')
      ],
      animationDuration: const Duration(milliseconds: 700),
      dotSize: 3.0,
      dotBgColor: Colors.transparent,
      dotSpacing: 10.0,
    ),
  );
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

    Widget category = Container(
        height: 200,
        //color: Colors.grey,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          children: <Widget>[
            CategoryItem("Promo", "image"),
            CategoryItem("Nearby", "image"),
            CategoryItem("Noodle", "image"),
            CategoryItem("FREESHIP", "image"),
            CategoryItem("Mua 2 tính tiền 1", "image"),
            CategoryItem("Món ngon 8k", "image"),
          ],
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            fakeSearchBox,
            imageCarousel,
            offers,
            category,
            FastChoice(),
            FastChoice()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Orders',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorite',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_rounded),
            label: 'Notification',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile',
            backgroundColor: Colors.yellow,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String image;
  CategoryItem(
    this.name,
    this.image,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.asset('images/yelloweyecat.jpg'),
            flex: 3,
          ),
          Text(
            "$name",
            style: TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
          )
        ],
      ),
      color: Colors.teal[100],
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
                                FlatButton(
                                  onPressed: () {
                                    // Perform some action
                                  },
                                  child: const Text('ACTION 1'),
                                ),
                                FlatButton(
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

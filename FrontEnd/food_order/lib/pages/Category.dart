import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Widget bestSelling = Container(
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
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
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
                            child: Image(
                              image: AssetImage("images/yelloweyecat.jpg"),
                              fit: BoxFit.fill,
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          )
                        ])),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 200,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Cẩu lương gia truyền ba đời, chính hiệu",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "90.000đ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "50.000đ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              //Expanded(child: Container()),
                                              IconButton(
                                                  icon: Icon(Icons.add_circle,
                                                      size: 30,
                                                      color: Colors.red),
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
                }),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
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
        color: Colors.grey,
        child: ListView(
          children: [
            Container(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: Image(
                  image: AssetImage("images/yelloweyecat.jpg"),
                ),
              ),
            ),
            bestSelling
          ],
        ),
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

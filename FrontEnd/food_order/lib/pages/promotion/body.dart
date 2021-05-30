import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            ItemPromotion(),
            ItemPromotion(),
            ItemPromotion(),
            ItemPromotion(),
            ItemPromotion(),
            ItemPromotion(),
            ItemPromotion(),
          ],
        ),
      ),
    );
  }
}

class ItemPromotion extends StatelessWidget {
  const ItemPromotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
            child: Row(children: [
              SizedBox(
                height: 100,
                width: 90,
                child: DecoratedBox(
                  child: Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: Border(
                          left: BorderSide(
                              width: 2,
                              color: Colors.red,
                              style: BorderStyle.solid))),
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.only(left: 5, top: 5),
                  height: 100,
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        'Giảm 40k, đơn tối thiểu 100k, quán đối tác ',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: SizedBox(
                            height: 20,
                            width: 90,
                            child: DecoratedBox(
                              child: Center(
                                child: Text(
                                  'ưu đãi có hạn',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            )),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Text(
                          'HSD: 12/02/2020',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ])),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Cart.dart';
import 'body.dart';

class CartItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Body(),
        bottomNavigationBar: CheckoutCart());
  }
}

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      height: 174,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.orange,
                    size: 25,
                  ),
                ),
                Spacer(),
                Text('Mã khuyến mãi'),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(text: 'Tổng:\n', children: [
                    TextSpan(
                        text: '\$10.12',
                        style: TextStyle(fontSize: 16, color: Colors.black))
                  ]),
                ),
                SizedBox(
                  width: 150,
                  child: MaterialButton(
                    height: 50,
                    minWidth: 100,
                    color: Colors.orange.shade400,
                    child: Text(
                      'Thanh toán',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.blue.shade100,
    title: Column(
      children: [
        Text(
          'Giỏ hàng',
          style: TextStyle(color: Colors.black),
        ),
        Text(
          '${demoCarts.length} sản phẩm',
          style: Theme.of(context).textTheme.caption,
        )
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'Cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.cart}) : super(key: key);
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    double getProportionateScreenWidth(double inputWidth) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (inputWidth / 375.0) * screenWidth;
    }

    return Row(
      children: <Widget>[
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset(cart.product.images),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(fontSize: 16, color: Colors.black),
              maxLines: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(
                text: '${cart.product.price}',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                children: [
                  TextSpan(
                      text: ' x${cart.numOfItem}',
                      style: TextStyle(color: Colors.grey))
                ]))
          ],
        )
      ],
    );
  }
}

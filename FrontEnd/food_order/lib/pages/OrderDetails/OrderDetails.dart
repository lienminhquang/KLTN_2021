import 'package:flutter/material.dart';

import 'OrderDetailsBody.dart';

class OrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: OrderDetailsBody(),
      appBar: _buildAppBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.redAccent,
      title: Column(
        children: [
          Text(
            'Chi tiết hóa đơn',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsBloc.dart';
import 'package:food_delivery/bloc/OrderDetails/OrderDetailsEvent.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryBloc.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryEvent.dart';
import 'package:food_delivery/bloc/OrderHistory/OrderHistoryState.dart';
import 'package:food_delivery/configs/AppConfigs.dart';
import 'package:food_delivery/pages/OrderDetails/OrderDetails.dart';
import 'package:food_delivery/view_models/Orders/OrderVM.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _tabController; // = TabController(length: 1, vsync: this);

  final List<Tab> myTabs = [
    Tab(
      text: 'Đang xử lý',
    ),
    Tab(
      text: 'Lịch sử',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildLoadedState(
      BuildContext context, OrderHistoryLoadedState state) {
    return Container(
      child: Container(
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.red,
              tabs: myTabs,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  IncomingOrder(state.incomingItems),
                  HistoryOrder(state.completedItems)
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, OrderHistoryErrorState state) {
    return Container(
      child: Center(
        child: Text(state.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
      if (state is OrderHistoryLoadingState) {
        return Center(child: Container(child: CircularProgressIndicator()));
      } else if (state is OrderHistoryLoadedState) {
        return _buildLoadedState(context, state);
      } else if (state is OrderHistoryErrorState) {
        return _buildErrorState(context, state);
      } else {
        throw "Unknow state!";
      }
    });
  }
}

class Item extends StatelessWidget {
  final OrderVM orderVM;
  Item(this.orderVM);
  @override
  Widget build(BuildContext context) {
    String name = "";
    int foodCount = orderVM.orderDetailVMs.length;
    double price = 0;
    DateTime? datetime;
    if (orderVM.orderStatusID == 4 || orderVM.orderStatusID == 5) {
      datetime = orderVM.datePaid;
    } else {
      datetime = orderVM.createdDate;
    }
    for (var item in orderVM.orderDetailVMs) {
      name += item.foodVM!.name + ", ";
      price += item.price *
          item.amount *
          (item.salePercent == null ? 1 : (100 - item.salePercent!) / 100);
    }
    if (orderVM.promotionAmount != null) {
      price -= orderVM.promotionAmount!;
    }

    return GestureDetector(
      onTap: () {
        context
            .read<OrderDetailsBloc>()
            .add(OrderDetailStartedEvent(orderVM.id));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return OrderDetails();
        }));
      },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 2)
        ]),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 100,
            //color: Colors.red,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 15,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          orderVM.orderStatusVM.name,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                      Icon(
                        Icons.remove,
                        size: 15,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          datetime == null
                              ? ""
                              : DateFormat.yMMMd().format(datetime),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 45,
                  color: Colors.white,
                  //color: Colors.grey.shade200,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  height: 25,
                  child: Row(
                    children: [
                      Text(
                        "\$${AppConfigs.AppNumberFormat.format(price)}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " ($foodCount Món)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Center(
                      //     child: Icon(
                      //       Icons.more_horiz,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryOrder extends StatelessWidget {
  final List<OrderVM> items;
  HistoryOrder(this.items);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<OrderHistoryBloc>().add(OrderHistoryRefreshEvent());
        },
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Item(items[index]);
            }),
      ),
    );
  }
}

class IncomingOrder extends StatelessWidget {
  final List<OrderVM> items;
  IncomingOrder(this.items);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<OrderHistoryBloc>().add(OrderHistoryRefreshEvent());
        },
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Item(items[index]);
            }),
      ),
    );
  }
}

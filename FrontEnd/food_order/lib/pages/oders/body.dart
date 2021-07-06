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
import 'OrderItem.dart';

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
              return OrderItem(items[index]);
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
              return OrderItem(items[index]);
            }),
      ),
    );
  }
}

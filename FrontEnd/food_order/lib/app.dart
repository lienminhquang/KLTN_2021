import 'package:flutter/material.dart';
import 'package:food_delivery/pages/chatbot/chatbotScreen.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/pages/cart/cart_screen.dart';
import 'package:food_delivery/pages/home/Home.dart';
import 'package:food_delivery/pages/oders/Orders.dart';
import 'package:food_delivery/pages/profile/Profile.dart';

import 'bloc/Cart/CartBloc.dart';
import 'bloc/Cart/CartEvent.dart';

class MotherBoard extends StatefulWidget {
  @override
  _MotherBoardState createState() => _MotherBoardState();
}

class _MotherBoardState extends State<MotherBoard> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    OderScreen(),
    CartScreen(),
    // NoficationScreen(),
    ProfileScreen(),
    ChatBotScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.receipt_long),
                label: "Order"),
            new BottomNavigationBarItem(
                backgroundColor: Colors.black87,
                icon: Icon(Icons.shopping_cart),
                label: "Cart"),
            // new BottomNavigationBarItem(
            //     backgroundColor: Colors.black87,
            //     icon: Icon(Icons.notifications_active_outlined),
            //     label: "Notification"),
            new BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            new BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.support_agent_outlined),
              label: "Amee",
            )
          ],
          onTap: (int index) {
            onTabTapped(index, context);
          }),
    );
  }

  Future<void> onTabTapped(int index, BuildContext context) async {
    _currentIndex = index;
    switch (_currentIndex) {
      case 1:
        break;
      case 2:
        //await context.read<CartModel>().fetchCartItems();
        //await context.read<CartModel>().fetchAddress();
        // context.read<ad>().fetchAll();
        context.read<CartBloc>().add(CartStartedEvent());
        break;
      default:
    }

    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:foodapp/pages/account/account_page.dart';
import 'package:foodapp/pages/auth/sign_in_page.dart';
import 'package:foodapp/pages/auth/sing_up_page.dart';
import 'package:foodapp/pages/cart/cart_history.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/order/order_page.dart';
import 'package:foodapp/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  //late PersistentTabController _controller;


  List pages= [
    MainFoodPage(),
    OrderPage(),
    CartHistory(),
    AccountPage(),

  ];

  void onTapNav(int index){
    setState(() {
      _selectIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectIndex],

      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0.0,
        selectedFontSize: 0.0,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Me"
          ),
        ],
      ),
    );
  }
}

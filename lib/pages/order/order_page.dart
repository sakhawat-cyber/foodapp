import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_app_bar.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/pages/order/view_order.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      // Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "My orders",),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: AppColors.yellowColor,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "current",
                ),
                Tab(
                  text: "history",
                ),
              ],
            ),
          ),
          Container(
            height: Dimensions.height20*2,
            child: TabBarView(
                controller: _tabController,
                children: [
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false),
            ]),
          )
        ],
      ),
    );
  }
}

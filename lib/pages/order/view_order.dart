import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/models/oder_model.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/utils/styles.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if(orderController.isLoading == false){
          late List<OrderModel> orderList;
          if(orderController.currentOrderList.isNotEmpty){
                orderList = isCurrent?
                orderController.currentOrderList.reversed.toList()
                :orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20/2,
                  vertical: Dimensions.height10/2,
              ),
              child:  ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                        onTap: () => null,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("#order ID", style: robotoRegular.copyWith(
                                          fontSize: Dimensions.font12)),
                                      SizedBox(width: Dimensions.width10/2),
                                      Text('#${orderList[index].id.toString()}')
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                        ),
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                          vertical: Dimensions.width10/2),
                                          child: Text('${orderList[index].orderStatus}',
                                          style: robotoMedium.copyWith(
                                            fontSize: Dimensions.font12,
                                            color: Theme.of(context).cardColor
                                          )
                                          ),
                                      ),
                                      SizedBox(height: Dimensions.height10/2),
                                      InkWell(
                                        onTap: ()=>null,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical: Dimensions.width10/2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/image/tracking.png",
                                                height: Dimensions.height30/2,width: Dimensions.width15,
                                                  color: Theme.of(context).primaryColor
                                              ),
                                              SizedBox(width: Dimensions.width10/2),
                                              Text("track order", style: robotoMedium.copyWith(
                                                fontSize: Dimensions.font12,
                                                color: Theme.of(context).primaryColor,
                                              ),)
                                            ],
                                          )
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.height10),
                          ],
                        )
                    );
                  }),
            ),
          );
        }else{
          return CustomLoader();
        }
      },),
    );
  }
}

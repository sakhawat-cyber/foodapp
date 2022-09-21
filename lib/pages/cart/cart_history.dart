import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for(int i = 0; i < getCartHistoryList.length; i++){
      //print(getCartHistoryList[i]["find"]);
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=>1);
      }
    }
    //print(cartItemsPerOrder);
    List<int> CartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<String> CartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder= CartItemsPerOrderToList();
    var listCunter = 0;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCunter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
      //Text(getCartHistoryList[listCunter].time!);
    }


    return Scaffold(
      //crating a map
      body: Column(
        children: [
          //header or app bar
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.mainColor,
                    backgroundColor: AppColors.yellowColor),
              ],
            ),
          ),
          //body
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList()
                .length>0?Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          for(int i = 0; i < itemsPerOrder.length; i++)
                            Container(
                              height: Dimensions.height30*4,
                              margin: EdgeInsets.only(
                                bottom: Dimensions.height20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //BigText(text: getCartHistoryList[listCunter].time!),
                                  //imidiately involve function
                              /*    ((){
                                    DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCunter].time!);
                                    var inputDate = DateTime.parse(parseDate.toString());
                                    var outputFormat = DateFormat("MM/dd/yyyy hh mm a");
                                    var outputDate = outputFormat.format(inputDate);
                                    return BigText(text: outputDate);
                                    //Text(getCartHistoryList[listCunter].time!);
                                  }()),*/
                                  timeWidget(listCunter),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(itemsPerOrder[i], (index) {
                                            if(listCunter< getCartHistoryList.length){
                                              listCunter++;
                                            }
                                            return index <= 2 ?
                                            CachedNetworkImage(
                                              imageUrl: AppConstants.BASE_URL+AppConstants.UPLOAD_URI+getCartHistoryList[listCunter-1].img!,
                                              imageBuilder: (context, imageProvider) => Container(
                                                width: Dimensions.height20*4,
                                                height: Dimensions.height20*4,
                                                margin: EdgeInsets.only(right: Dimensions.width10/2),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) => Image.network(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URI+getCartHistoryList[listCunter-1].img!),
                                            )
                                                : Container();
                                            /*Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          AppConstants.BASE_URL+AppConstants.UPLOAD_URI+getCartHistoryList[listCunter-1].img!
                                      )
                                    )
                                  ),
                                );*/
                                          })
                                      ),
                                      Container(
                                        height: Dimensions.height20*4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SmallText(text: "total",color: AppColors.titleColor),
                                            BigText(text: itemsPerOrder[i].toString()+" Items", color: AppColors.titleColor),
                                            GestureDetector(
                                              onTap: (){
                                                var orderTime = CartOrderTimeToList();
                                                //print("Order time "+orderTime[i].toString());
                                                Map<int, CartModel>moreOrder = {};
                                                for(int j = 0; j < getCartHistoryList.length; j++){
                                                  if(getCartHistoryList[j].time==orderTime[i]){
                                                    //print("My order time is "+orderTime[i]);
                                                    //print("The cart or product id is "+getCartHistoryList[j].id.toString());
                                                    moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                        CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                    );
                                                    //print("product info is "+jsonEncode(getCartHistoryList[j]));
                                                  }
                                                }
                                                Get.find<CartController>().setItems = moreOrder;
                                                Get.find<CartController>().addToCartList();
                                                Get.toNamed(RouteHelper.getCartPage());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions.width10,
                                                  vertical: Dimensions.height10/2,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                    border: Border.all(width: 1, color: AppColors.mainColor)
                                                ),
                                                child: SmallText(text: "One more",color: AppColors.mainColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          //Text("Hi there"+i.toString())
                        ],
                      )
                  ),
                ))
                :SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                  child: const Center(
                    child: NoDatapage(
                        text: "Your didn't buy anything so far!",
                        imgPath: "assets/image/empty_box.jpg"
            ),
                  ),
                );
          })
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/common_text_button.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/base/show_custom_sanckbar.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/models/place_order_model.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/order/delivery_option.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/utils/styles.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/pages/order/payment_option_button.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24
                    ),
                  ),
                  SizedBox(width: Dimensions.width20*5),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24
                  ),
                ],

              )
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController
                .getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: _cartList.length,
                          itemBuilder: (_, index){
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20*5,
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var popularIndex = Get.find<PopularProductController>().
                                      popularProductList.
                                      indexOf(_cartList[index].product!);
                                      if(popularIndex >= 0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                      }
                                      else{
                                        var recommendedIndex = Get.find<RecommendedProductController>().
                                        recommendedProductList.
                                        indexOf(_cartList[index].product!);
                                        //Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                        if(recommendedIndex<0){
                                          Get.snackbar(
                                              "History Product", "Product review is not availble for history products!",
                                              backgroundColor: AppColors.mainColor,
                                              colorText: Colors.white
                                          );
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                        }
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URI + cartController.getItems[index].img!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            width: Dimensions.height20*5,
                                            height: Dimensions.height20*5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  Dimensions.radius20),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.network(AppConstants.BASE_URL + AppConstants.UPLOAD_URI + cartController.getItems[index].img!),
                                    ),
                                  ),
                                  /*
                                Container(
                                  width: Dimensions.height20*5,
                                  height: Dimensions.height20*5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.BASE_URL + AppConstants.UPLOAD_URI + cartController.getItems[index].img!
                                      )
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white,
                                  ),
                                ),

                                 */
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartController.getItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: "\$ ${cartController.getItems[index].price.toString()}",
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(_cartList[index].product!, -1);
                                                        },
                                                        child: Icon(Icons.remove, color: AppColors.signColor)
                                                    ),
                                                    SizedBox(width: Dimensions.width10/2),
                                                    BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                    SizedBox(width: Dimensions.width10/2),
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(_cartList[index].product!, 1);
                                                        },
                                                        child: Icon(Icons.add, color: AppColors.signColor)
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                )
            )
                :NoDatapage(text: "Your Cart Page Is Empty!");
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
          _noteController.text = orderController.foodNote;
          return GetBuilder<CartController> (builder: (cartController){
            return Container(
              height: Dimensions.bottomHeightBar+50,
              padding: EdgeInsets.only(top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: cartController.getItems.length>0
                  ? Column(
                children: [
                  InkWell(
                    onTap: ()=>showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_){
                          return Column(
                            children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dimensions.radius20),
                                            topRight: Radius.circular(Dimensions.radius20),
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: Dimensions.height350*2,
                                            padding: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              top: Dimensions.height20,
                                            ),
                                            child: Column(
                                              children: [
                                                const PaymentOptionButton(
                                                  icon: Icons.money,
                                                  title: "cash on delivery",
                                                  subTitle: "You after getting the delivery",
                                                  index: 0,
                                                ),
                                                SizedBox(height: Dimensions.height10/2),
                                                const PaymentOptionButton(
                                                  icon: Icons.paypal_outlined,
                                                  title: "Digital Payment",
                                                  subTitle: "safer and faster way of payment.",
                                                  index: 1,
                                                ),
                                                SizedBox(height: Dimensions.height30),
                                                Text("Delivery Options", style: robotoMedium),
                                                SizedBox(height: Dimensions.height10/2),
                                                DeliveryOptions(
                                                    value: "Delivery",
                                                    title: "Home Delivery",
                                                    isFree: false,
                                                    amount: double.parse(Get.find<CartController>().totalAmount.toString())
                                                ),
                                                SizedBox(height: Dimensions.height10/2),
                                                const DeliveryOptions(
                                                  value: "Take away",
                                                  title: "take away",
                                                  isFree: true,
                                                  amount: 10.0,
                                                ),
                                                SizedBox(height: Dimensions.height20),
                                                Text("Additional notes", style: robotoMedium),
                                                AppTextField(
                                                  textController: _noteController,
                                                  hintText: "",
                                                  icon: Icons.note,
                                                  maxLines: true,
                                                )
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          );
                        }
                    ).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CommonTextButton(text: "payment optinos"),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.width10/2),
                            BigText(text: "\$ " + cartController.totalAmount.toString()),
                            SizedBox(width: Dimensions.width10/2),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            //popularProduct.addItem(product);
                            //print("tapped");
                            if(Get.find<AuthController>().userLoggedIn()){
                              print("loged in");
                              //cartController.addToHistory();
                              if(Get.find<LocationController>().addressList.isEmpty){
                                Get.toNamed(RouteHelper.getAddressPage());
                                //Get.offNamed(RouteHelper.getInitial());
                              }else{
                                //Get.offNamed(RouteHelper.getInitial());
                                //Get.offNamed(RouteHelper.getPaymentPage("100127", Get.find<UserController>().userModel!.id!));
                                var location = Get.find<LocationController>().getUserAddress();
                                var cart = Get.find<CartController>().getItems;
                                var user = Get.find<UserController>().userModel;
                                PlaceOrderBody placeOrder = PlaceOrderBody(
                                    cart: cart,
                                    orderAmount: 100.0,
                                    distance: 10.0,
                                    scheduleAt: "",
                                    orderNote: orderController.foodNote,
                                    address: location.address,
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                    contactPersonName: user!.name,
                                    contactPersonNumber: user!.phone,
                                    orderType: orderController.orderType,
                                    paymentMethod: orderController.paymentIndex == 0?"cash_on_delivery" : "digital_payment",
                                );

                                Get.find<OrderController>().placeOrder(
                                    placeOrder,
                                    _callback
                                );
                              }
                            }else{
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: CommonTextButton(text: "check out",)
                      ),
                    ],
                  )
                ],
              ) : Container(),
            );
          });
        })
    );
  }

  void _callback(bool isSuccess, String message, String orderId){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex == 0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderId, "success"));
      }else{
        Get.offNamed(RouteHelper.getPaymentPage(orderId, Get.find<UserController>().userModel!.id));
      }
    }else{
      showCustomSanckBar(message);
    }
  }

}

import 'package:foodapp/models/oder_model.dart';
import 'package:foodapp/pages/address/add_address_page.dart';
import 'package:foodapp/pages/address/pick_address_map.dart';
import 'package:foodapp/pages/auth/sign_in_page.dart';
import 'package:foodapp/pages/cart/cart_page.dart';
import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/pages/food/recommended_food_detail.dart';
import 'package:foodapp/pages/home/home_page.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/payment/order_success_page.dart';
import 'package:foodapp/pages/payment/payment_page.dart';
import 'package:foodapp/pages/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
class RouteHelper{
  static const String splashPage = "/splash-screen";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getSplashPage()=>"$splashPage";
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId &page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id, int userId) => '$payment ? id = $id &userId = $userId';
  static String getOrderSuccessPage(String orderID, String status) => '$orderSuccess ? id = $orderID&status = $status';


  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddress = Get.arguments;
      return _pickAddress;
    }),

    GetPage(name: splashPage, page:()=> SplashScreen()),
    GetPage(name: initial, page: ()=>HomePage(), transition: Transition.fade),
    GetPage(name: signIn, page: ()=>SignInPage(),transition: Transition.fade),
    
    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId']!;
      var page = Get.parameters["page"]!;
      return PopularFoodDetail(pageId:int.parse(pageId!), page: page!);
    },
      transition: Transition.fadeIn
    ),
  /*GetPage(name: moreFood, page: (){
  return MoreFood(pageId:int.parse(Get.parameters['id']!), page:Get.parameters['page']!);
  },*/
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId']!;
      var page = Get.parameters["page"]!;
      //return RecommendedFoodDetail(pageId:int.parse(Get.parameters['pageId'].toString()), page:Get.parameters['page']!);
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page:page!);
    },
        transition: Transition.fadeIn
    ),
    
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn,
    ),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    }),
    
    GetPage(name: payment, page: ()=>PaymentPage(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userId']!),
        )
    )),
    GetPage(name: orderSuccess, page: () => OrderSuccessPage(
      orderID:Get.parameters['id']!,
      status: Get.parameters['status'].toString().contains("success")?1:0,
      ))

  ];
}

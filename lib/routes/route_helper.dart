import 'package:foodapp/pages/cart/cart_page.dart';
import 'package:foodapp/pages/food/popular_food_detail.dart';
import 'package:foodapp/pages/food/recommended_food_detail.dart';
import 'package:foodapp/pages/home/home_page.dart';
import 'package:foodapp/pages/home/main_food_page.dart';
import 'package:foodapp/pages/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
class RouteHelper{
  static const String splashPage = "/splash-screen";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";


  static String getSplashPage()=>"$splashPage";
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId &page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    
    GetPage(name: splashPage, page:()=> SplashScreen()),
    GetPage(name: initial, page: ()=>HomePage()),
    
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
    )
  ];
}

import 'package:foodapp/base/show_custom_sanckbar.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode == 401){
      Get.offNamed(RouteHelper.getSignInPage());
    }else{
      showCustomSanckBar(response.statusText!);
    }
  }
}
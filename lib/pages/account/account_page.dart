import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/account_widgets.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().UserLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      /*print("user has logged in");*/
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(text: "Profile",size: 24,color: Colors.white,),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn
            ?(userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30),
              Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: userController.userModel!.name)),
                        SizedBox(height: Dimensions.height20),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: userController.userModel!.phone)),
                        SizedBox(height: Dimensions.height20),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: userController.userModel!.email)),
                        SizedBox(height: Dimensions.height20),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_on,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: "Fill in your adderss")),
                        SizedBox(height: Dimensions.height20),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.message_outlined,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.redAccent,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: "Messages")),
                        SizedBox(height: Dimensions.height20),
                        GestureDetector(
                          onTap: (){
                            if(Get.find<AuthController>().UserLoggedIn()){
                              Get.find<AuthController>().ClearShareData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.offNamed(RouteHelper.getSignInPage());
                            }else{
                              print("loged Out");
                            }
                          },
                          child: AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.logout,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.redAccent,
                                iconSize: Dimensions.height10*5/2,
                                size: Dimensions.height10*5,
                              ),
                              bigText: BigText(text: "Logout")),
                        ),
                        SizedBox(height: Dimensions.height20),
                      ],
                    ),
                  )),
            ],
          ),
        ):CustomLoader())
            :Container(child: Center(child: Text("You must Login")));
      })
    );
  }
}

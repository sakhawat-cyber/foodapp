import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/pages/auth/sing_up_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_sanckbar.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      //var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

     if(email.isEmpty){
        showCustomSanckBar("Type in your email address", title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSanckBar("Type in your valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSanckBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSanckBar("Password can not be less than six characters", title: "Password");
      }else {
        //showCustomSanckBar("All went well", title: "Perfect");
        /*print(signUpBody.toString());*/
        authController.login(email, password).then((status){
          if(status.isSuccess){
            //print("Success Registration");
            //Get.toNamed(RouteHelper.getCartPage());
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSanckBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
       return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.06),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20*4,
                    backgroundImage: AssetImage("assets/image/logo part 1.png"),
                  ),
                ),
              ),

              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        //fontWeight: FontWeight.bold,
                        color:Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),

              //your email
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20),

              //Your password
              AppTextField(
                  textController: passwordController,
                  hintText: "password",
                  icon: Icons.password_sharp, isObscure: true),
              SizedBox(height: Dimensions.height20),

              //tag line
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )
                  )),
                  SizedBox(width: Dimensions.width20),
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05),

              //sign in buttom
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05),

              //sign in options
              RichText(
                  text: TextSpan(
                      text: "Don\'t an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                            text: " Create",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                            )),
                      ]
                  )),
            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}

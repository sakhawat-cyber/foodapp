import 'package:foodapp/data/repository/auth_repo.dart';
import 'package:foodapp/models/response_model.dart';
import 'package:foodapp/models/signup_body_model.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration (SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login (String email, String password) async {
   /* print("Getting token");
    print(authRepo.getUserToken().toString());*/
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
     /* print("Backand Token");*/
      authRepo.saveUserToken(response.body["token"]);
      /*print("my token is"+response.body["token"].toString());*/
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
   authRepo.saveUserNumberAndPassword(number, password);
  }

  bool UserLoggedIn()  {
    return authRepo.UserLoggedIn();
  }

  bool ClearShareData(){
    return authRepo.ClearShareData();
  }

}


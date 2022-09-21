import 'package:foodapp/data/repository/user_repo.dart';
import 'package:foodapp/models/response_model.dart';
import 'package:foodapp/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });
  bool _isLoading = false;

  UserModel? _userModel;
  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    update();
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "Sucessfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}

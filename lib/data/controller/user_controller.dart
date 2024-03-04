import 'package:food_delivery_app/data/model/response_model.dart';
import 'package:food_delivery_app/data/model/user_model.dart';
import 'package:food_delivery_app/data/reposetory/user_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;
  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    update();
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.status == 200) {
      responseModel = ResponseModel(true, 'Successfully');
      _userModel = UserModel.fromJson(response.body);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;

    update();
    return responseModel;
  }
}

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
    print('User Controller :- get User Info Start');
    // _isLoading = true;
    // update();

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, 'Successfully');
    } else {
      responseModel =
          ResponseModel(false, "statusText : ${response.statusText!}");
    }
    update();
    print('User Controller :- get User Info End');
    return responseModel;
  }
}

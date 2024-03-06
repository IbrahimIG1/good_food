// import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/model/response_model.dart';
import 'package:food_delivery_app/data/model/signup_model.dart';
import 'package:food_delivery_app/data/reposetory/auth_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // register (take userData and token)
  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    update();
    ResponseModel? responseModel;
    print('registration Controller Start');

    Response response = await authRepo.registration(signUpModel);
    print(' => registration Controller End');

    if (response.statusCode == 200) {
      print(' => if (response.statusCode == 200) Start');

      authRepo.saveUserToken(response.body['token']);
      print(
          "response body token in registration  : ${response.body['token'].toString()}");
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // login
  Future<ResponseModel> login(
      {required String email,
      required String password,
      required String phone}) async {
    print("Getting token");
    // authRepo.getUserToken();
    // print(authRepo.getUserToken().toString());

    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response =
        await authRepo.login(email: email, password: password, phone: phone);
    // authRepo.saveUserToken(response.body['token']);
    // print("response.body['token'] ==>> ${response.body['token']}");
    if (response.statusCode == 200) {
      print("Backed token");
      AppConstants.TOKEN = authRepo.saveUserToken(response.body['token']).toString();
      // print(
          "response body token in Login  : ${response.body['token'].toString()}";
      responseModel = ResponseModel(true, response.body['token']);
      // print('TOKEN In LOGIN');
      // print(AppConstants.TOKEN);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<String> getUserToken() async {
    // print("authRepo.getUserToken() ................>>>${authRepo.getUserToken().toString()}");
    return await authRepo.getUserToken();
  }

  void saveUserNumAndPassword(String num, String password) async {
    authRepo.saveUserNumAndPassword(num, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    print('clear Done');
    return authRepo.clearSharedData();
  }
}

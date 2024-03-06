import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/model/signup_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  // convert data to json and post it on server
  Future<Response> registration(SignUpModel signUpModel) async {
    print(' => registration Repo Start');
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpModel.toJson());
  }

  Future<Response> login(
      {required String email,
      required String password,
      required String phone}) async {
    print('In login Repo');
    return await apiClient.postData(AppConstants.LOGIN_URI,
        {"email": email, "password": password, "phone": phone});
  }

// save the new token in header
  Future<bool> saveUserToken(String token) async {
    print(' In save User Token ');
    apiClient.token = token;
    apiClient.updateHeader(token);
    AppConstants.TOKEN = token;
    // print("AppConstants.TOKEN => ${AppConstants.TOKEN}");

    return await sharedPreferences.setString("token", token);
  }

  Future<String> getUserToken() async {
    print('getUserToken => ${sharedPreferences.getString}');
    return await sharedPreferences.getString("token") ?? "";
  }

  bool userLoggedIn() {
    print('Is User Logged In');
    print(sharedPreferences.containsKey("token"));
    return sharedPreferences.containsKey("token");
  }

  // UserModel getUserData() {
  //   UserModel userModel;
  //   userModel.name =
  //   return userModel;
  // }

  Future<void> saveUserNumAndPassword(String num, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, num);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove('token');
    AppConstants.TOKEN = '';
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = '';
    apiClient.updateHeader("");
    return true;
  }
}

import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    print('User Repo :- get User Info Start');
    return await apiClient.getData(
      AppConstants.USER_INFO,
      headers:  {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer${AppConstants.TOKEN}'
    }
    );
  }
}

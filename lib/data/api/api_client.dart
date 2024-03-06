import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeader;
  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString("token")??"";
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      // print("headers : ${headers}");
      // print("_mainHeader : ${_mainHeader}");
      // print('Hello From try Get data ApiCleint');
      // print(
      //     'sharedPreferences Token Get String =>${sharedPreferences.getString("token")!}');
      // print('AppConstance Token  =>${sharedPreferences.getString("token")!}');
      Response response = await get(uri, headers: headers ?? _mainHeader);
      // print("response.statusCode in getData=>> ${response.statusCode}");
      return response;
    } catch (e) {
      print('Hello From catch Get data ApiCleint');

      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  //  send user data to server
  Future<Response> postData(String uri, dynamic body) async {
    print("body  from postData is ${body.toString()}");
    try {
      Response response = await post(uri, body, headers: _mainHeader);

      return response;
    } on Exception catch (e) {
      print("In Catch Error");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // put the new token in header
  void updateHeader(String token) async {
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    print("updated Headers");
  }
}

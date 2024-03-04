import 'package:dio/dio.dart';
import 'package:food_delivery_app/utils/app_constants.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      receiveDataWhenStatusError: true,
    ));
  }
  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    // String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio!.post(
      path,
      data: data,
    );
  }

  // static Future<Response> getData({
  //   String? path,
  //   Map<String, dynamic>? data,
  //   String? lang = 'en',
  //   String? token,
  // }) async {
  //   dio!.options.headers = {
  //     'Content-Type': 'application/json',
  //     'lang': lang,
  //     'Authorization': token ?? ''
  //   };
  //   return await dio!.get(
  //     path!,
  //     queryParameters: data,
  //   );
  // }
}

import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAdressFromGeocode(LatLng latLng) async {
    // take to the server and get data

    /* this lat and lng in getData must be the same spilling in php data base
        in this path
           C:\xampp\htdocs\shopping-app\app\Http\Controllers\Api\V1\ConfigController.php
45.51563, -122.677433

          http://192.168.1.8:8000/api/v1/config/geocode-api?lat=45.51563&lng=-122.677433
           
    */
    return await apiClient.getData('${AppConstants.GEOCODE_URL}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }
}

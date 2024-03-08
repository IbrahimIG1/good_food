import 'package:food_delivery_app/data/model/adress_model.dart';
import 'package:food_delivery_app/data/reposetory/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark(); // to save position do you want
  List<AdressModel> _adressList = [];
  List<AdressModel> get adressList => _adressList;
  List<AdressModel>? _allAdressList;
  List<String> _adressTypeList = ['home', 'office', 'other'];
  int _adressTypeIndex = 0;
  late Map<String, dynamic> _getAdress;
  Map get getAdress => _getAdress;

  late GoogleMapController _mapController;
  bool _updateAdressData = true;
  bool _changeAdress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapContoller(GoogleMapController mapController) {
    // save mapController when map created on page screen
    _mapController = mapController;
    print('set Map Contoller Done');
  }

  // save new position when user move small map in (_position)
  void updatePosition(CameraPosition position, bool fromAdress) async {
    if (_updateAdressData) {
      _loading = true;
      update();
      try {
        if (fromAdress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              altitudeAccuracy: 1,
              heading: 1,
              headingAccuracy: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAdress) {
          // here talk to the server
          print('position.altitude is = ${position.target.latitude}');
          print('position.longitude is = ${position.target.longitude}');

          String _adress = await getAdressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          print("_adress => $_adress");
        }
      } catch (e) {
        print("Error In Catch Error  ===>>  ${e}");
      }
    }
  }

  Future<String> getAdressFromGeocode(LatLng latLng) async {
    String _adress = " Known adress no Found";
    Response response = await locationRepo.getAdressFromGeocode(latLng);

    if (response.body['status'] == 'OK') {
      _adress = response.body['results'][0]['formatted_address'].toString();
      print(_adress);
      print('get Adress From Geocode Adress => $_adress');
    } else {
      print('Error Getting the Google Api');
      print(response.body['status']);
    }
    return _adress;
  }
}

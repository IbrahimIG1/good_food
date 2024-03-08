import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/auth_controller.dart';
import 'package:food_delivery_app/data/controller/location_controller.dart';
import 'package:food_delivery_app/data/controller/user_controller.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAdressPage extends StatefulWidget {
  const AddAdressPage({super.key});

  @override
  State<AddAdressPage> createState() => _AddAdressPageState();
}

class _AddAdressPageState extends State<AddAdressPage> {
  TextEditingController _adressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 50);
  late LatLng _initialPosition = LatLng(30.679256932119344, 31.03529697330752);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PermissionStatus status = await Permission.location.status;
    // if (status.isDenied) {
    //   print("Requist permission Location");
    // Permission.location.request();
    // }

    LocationController locationController = Get.find<LocationController>();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (locationController.adressList.isNotEmpty) {
      // this will open the camera on user location he had saved Direct
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(locationController.getAdress['latitude']),
        double.parse(locationController.getAdress['langitude']),
      ));
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(locationController.getAdress['latitude']),
        double.parse(locationController.getAdress['langitude']),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adress Page'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(width: 2, color: Theme.of(context).primaryColor),
              ),
              child: Stack(children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraIdle: () {
                    locationController.updatePosition(_cameraPosition, true);
                  },
                  onCameraMove: ((position) => _cameraPosition = position),
                  onMapCreated: (GoogleMapController controller) {
                    locationController.setMapContoller(controller);
                  },
                )
              ]),
            )
          ],
        );
      }),
    );
  }
}

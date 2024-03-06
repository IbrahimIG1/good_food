// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:food_delivery_app/data/controller/auth_controller.dart';
// import 'package:food_delivery_app/data/controller/user_controller.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AddAdressPage extends StatefulWidget {
//   const AddAdressPage({super.key});

//   @override
//   State<AddAdressPage> createState() => _AddAdressPageState();
// }

// class _AddAdressPageState extends State<AddAdressPage> {
//   TextEditingController _adressController = TextEditingController();
//   TextEditingController _contactPersonName = TextEditingController();
//   TextEditingController _contactPersonNumber = TextEditingController();
//   late bool _isLogged;
//   final CameraPosition _cameraPosition =
//       CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
//   late LatLng _initialPosition;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _isLogged = Get.find<AuthController>().userLoggedIn();
//     if (_isLogged && Get.find<UserController>().userModel == null) {
//       Get.find<UserController>().getUserInfo();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

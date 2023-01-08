import 'package:get/get.dart';
class Dimentions
{
    static double screenHeight = Get.context!.height;
    static double screenWidth = Get.context!.width;
  
  static double pageView = screenHeight/2.51; //  803.64 / 320
  static double pageViewContainer = screenHeight/3.65; //  803.64 / 220
  static double pageTextContainer = screenHeight/6.18; //  803.64 / 130
  
  // dynamic height Padding and margin
  static double height10 = screenHeight/80.36;  //  803.64 / 10
  static double height20 = screenHeight/40.18;  //  803.64 / 20
  static double height30 = screenHeight/26.788;  //  803.64 / 30
  static double height45 = screenHeight/17.858;  //  803.64 / 45
  static double height90 = screenHeight/8.9;  //  803.64 / 90
  static double height120 = screenHeight/6.697;  //  803.64 / 120
  // dynamic height Padding and margin
  static double width5 = screenHeight/160.728;  //  392.727 / 10
  static double width10 = screenHeight/80.36;  //  392.727 / 10
  static double width15 = screenHeight/53.576;  //  392.727 / 15
  static double width20 = screenHeight/40.18;  //  392.727 / 20
  static double width30 = screenHeight/26.788;  //  392.727 / 30
  static double width45 = screenHeight/17.858;  //  803.64 / 30
  static double width120 = screenHeight/6.697;  //  803.64 / 120

  static double font20 = screenHeight/40.18;  //  803.64 / 20
  static double font15 = screenHeight/53.576;  //  803.64 / 16
  static double font26 = screenHeight/30.909;  //  803.64 / 20

  // radius
  static double radius15 = screenHeight/53.576; //  803.64 / 15
  static double radius20 = screenHeight/40.18; //  803.64 / 20
  static double radius30 = screenHeight/26.88; //  803.64 / 30

  static double iconSize24 = screenHeight/33.485; //  803.64 / 24
  static double iconSize16 = screenHeight/50.2275; //  803.64 / 16

  // list view size
  static double listViewImageSize = screenWidth/3.272725; //  392.727 / 120
  static double listViewTxtContainerSize = screenWidth/4.364; //  392.727 / 120

  //  popular food size
  static double popularFoodImgSize = screenHeight / 2.296;

  //  Bottom height Bar
  static double bottomHeightBar = screenHeight/6.697;  //  803.64 / 120




}
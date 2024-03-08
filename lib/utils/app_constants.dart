class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  // static const String BASE_URL = "http://mvs.bslmeiyu.com";
  // static const String BASE_URL = "http://127.0.0.1:8000";  // localhost on computer only
  static const String BASE_URL =
      "http://192.168.1.8:8000"; // localhost on real device

  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String DRINKS_URI = "/api/v1/products/drinks";

  // user and auth end point
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO = "/api/v1/customer/info";

  static const String USER_ADRESS = "user_adress";
  static const String GEOCODE_URL = "/api/v1/config/geocode-api";

  // to get network image call this variable frist IMAGE_URL + image path from any list
  static const String IMAGE_URL = "$BASE_URL/uploads/";

  static String TOKEN = "";
  static const String PASSWORD = "";
  static const String PHONE = "";

  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}

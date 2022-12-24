class AppConstants{
  static const String APP_NAME = "Byrani House";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://10.0.2.2:8000";
  /*
  /api/HTTP/Controllers/api/v1/products/popular
   */
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PROCUCT_URI = "/api/v1/products/recommended";
  //static const String BIRYANI_URI = "/api/v1/products/biryani";
  static const String UPLOAD_URI = "/uploads/";

  //user and auth end point
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  //new
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";

  /*config*/

  static const String GEOCODE_URI = "/api/v1/config/geocode_api";
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String SEARCH_LOCATION_URI = '/api/v1/config/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place_api_details';

  /*orders*/
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

}
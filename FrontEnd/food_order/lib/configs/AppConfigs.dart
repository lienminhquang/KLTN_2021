import 'package:intl/intl.dart';

class AppConfigs {
  static const String URL_BaseAPI = "https://localhost:6001";
  static const String URL_UserRouteAPI = URL_BaseAPI + "/api/Users";
  static const String URL_CategoryRouteAPI = URL_BaseAPI + "/api/Category";
  static const String URL_FoodRouteAPI = URL_BaseAPI + "/api/Food";
  static const String URL_RatingsRouteAPI = URL_BaseAPI + "/api/Ratings";
  static const String URL_CartsRouteAPI = URL_BaseAPI + "/api/Carts";
  static const String URL_AddressesRouteAPI = URL_BaseAPI + "/api/Addresses";
  static const String URL_OrdersRouteAPI = URL_BaseAPI + "/api/Orders";
  static const String URL_NotificationsRouteAPI =
      URL_BaseAPI + "/api/Notifications";
  static const String URL_PromotionsRouteAPI = URL_BaseAPI + "/api/Promotions";

  static const String URL_Images = URL_BaseAPI + "/user-content";

  static final NumberFormat AppNumberFormat = NumberFormat();
}

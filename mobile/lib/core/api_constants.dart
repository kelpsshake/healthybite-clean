/// API constants untuk semua endpoint dan base URL
class ApiConstants {
  // Untuk web gunakan localhost, untuk Android emulator gunakan 10.0.2.2
  static const String baseUrl = 'http://localhost/healthybite-clean/backend/public/api';
  static const String baseImage = 'http://localhost/healthybite-clean/backend/public/storage/';

  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String banners = '$baseUrl/banners';
  static const String merchants = '$baseUrl/merchants';
  static const String searchProducts = '$baseUrl/products/search';
  static const String orders = '$baseUrl/orders';
  static const String merchantOrders = '$baseUrl/merchant/orders';
  static const String merchantProfile = '$baseUrl/merchant/profile';
}
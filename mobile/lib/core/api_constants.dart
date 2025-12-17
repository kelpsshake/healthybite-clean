/// API constants untuk semua endpoint dan base URL
class ApiConstants {
  // PENTING: Gunakan IP komputer untuk testing di device/emulator
  // - Untuk Android Emulator: gunakan 10.0.2.2
  // - Untuk device fisik/iOS: gunakan IP komputer (10.231.125.189)
  // - Untuk web: gunakan localhost
  
  // Untuk Android Emulator gunakan 10.0.2.2 (special IP untuk host machine)
  static const String baseUrl = 'http://10.0.2.2/healthybite-clean/backend/public/api';
  static const String baseImage = 'http://10.0.2.2/healthybite-clean/backend/public/storage/';

  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String banners = '$baseUrl/banners';
  static const String merchants = '$baseUrl/merchants';
  static const String searchProducts = '$baseUrl/products/search';
  static const String orders = '$baseUrl/orders';
  static const String merchantOrders = '$baseUrl/merchant/orders';
  static const String merchantProfile = '$baseUrl/merchant/profile';
}

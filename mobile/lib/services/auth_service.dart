import 'package:dio/dio.dart';
import '../core/api_constants.dart';
import 'dart:io';

/// Service untuk operasi autentikasi (login, register, update profile)
class AuthService {
  final Dio _dio = Dio();

  /// Mendaftarkan user baru
  Future<Map<String, dynamic>> register(String name, String email, String password, String phone) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Registrasi Gagal';
      }
    } on DioException {
      throw 'Gagal terhubung ke server.';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Melakukan login dan mendapatkan access token
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 10);
      _dio.options.receiveTimeout = const Duration(seconds: 10);
      
      print("Attempting login to: ${ApiConstants.login}");
      print("Login credentials - Email: $email, Password length: ${password.length}");
      
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");
      print("Response has access_token: ${response.data.containsKey('access_token')}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response.data['message'] ?? 'Login Gagal';
      }
    } on DioException catch (e) {
      print("Dio Error Type: ${e.type}");
      print("Dio Error Message: ${e.message}");
      print("Dio Error Response: ${e.response?.data}");
      
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout) {
        throw 'Timeout: Server tidak merespons. Pastikan Laragon running.';
      } else if (e.type == DioExceptionType.connectionError) {
        throw 'Koneksi gagal. Pastikan backend Laravel berjalan di http://localhost/healthybite-clean/backend/public';
      }
      
      throw 'Gagal terhubung ke server: ${e.message}';
    } catch (e) {
      print("General Error: $e");
      throw e.toString();
    }
  }

  /// Update profil user dengan opsi upload gambar
  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    required String email,
    required String phone,
    File? imageFile,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        if (imageFile != null)
          'image': await MultipartFile.fromFile(imageFile.path, filename: 'profile.jpg'),
      });

      final response = await _dio.post(
        "${ApiConstants.baseUrl}/profile/update",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Gagal update profil';
    }
  }
}
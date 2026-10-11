import 'package:dio/dio.dart';

import '../../network/api.dart';
import '../models/user_profile.dart';


class AuthService {
  final Dio _dio = Api().dio;

  Future<void> login({required String email, required String password}) async {
    try {
      final res = await _dio.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );
      Api().accessToken = res.data['access_token'];
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _dio.post(
        'users/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'avatar': 'https://picsum.photos/800',
        },
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<UserProfile> getProfile() async {
    try {
      final res = await _dio.get('auth/profile');
      return UserProfile.fromJson(res.data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  void logout() => Api().accessToken = null;
}
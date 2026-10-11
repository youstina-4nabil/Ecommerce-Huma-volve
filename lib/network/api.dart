import 'package:dio/dio.dart';

class Api {
  static final Api _instance = Api._internal();
  factory Api() => _instance;

  final Dio dio;
  String? accessToken;

  Api._internal()
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.escuelajs.co/api/v1/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          handler.next(options);
        },
      ),
    );
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timed out, please try again');
      case DioExceptionType.connectionError:
        return ApiException('No internet connection');
      default:
        break;
    }

    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      final m = data['message'];
      return ApiException(m is List ? m.join('\n') : m.toString());
    }
    if (e.response?.statusCode == 401) {
      return ApiException('Invalid email or password');
    }
    return ApiException('Something went wrong, please try again');
  }

  @override
  String toString() => message;
}
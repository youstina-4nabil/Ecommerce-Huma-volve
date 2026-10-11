import 'package:dio/dio.dart';

import '../../network/api.dart';
import '../models/category.dart';
import '../models/product.dart';


class ProductService {
  final Dio _dio = Api().dio;

  Future<List<Product>> getProducts({
    int? categoryId,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get(
        'products',
        queryParameters: {
          'offset': offset,
          'limit': limit,
          if (categoryId != null) 'categoryId': categoryId,
        },
      );
      return (res.data as List).map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final res = await _dio.get('categories');
      return (res.data as List).map((e) => Category.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
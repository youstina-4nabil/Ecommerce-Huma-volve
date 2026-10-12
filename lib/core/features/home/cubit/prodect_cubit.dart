import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huma/core/features/home/cubit/prodect_state.dart';
import '../../../../network/api.dart';
import '../../../models/category.dart';

import '../../../services/prodect_service.dart';


class ProductsCubit extends Cubit<ProductsState> {
  final ProductService _service;

  ProductsCubit(this._service) : super(const ProductsState());

  // تحميل أولي للمنتجات + الأقسام
  Future<void> loadData() async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final results = await Future.wait([
        _service.getProducts(),
        _service.getCategories(),
      ]);
      final products = results[0] as List;
      final categories = results[1] as List;

      emit(state.copyWith(
        status: ProductsStatus.success,
        products: products.cast(),
        categories: [const Category(name: 'All'), ...categories.cast<Category>()],
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
        status: ProductsStatus.failure,
        errorMessage: e.message,
      ));
    }
  }

  // اختيار قسم
  Future<void> selectCategory(int index) async {
    if (index == state.selectedCategoryIndex) return;

    emit(state.copyWith(
      status: ProductsStatus.loading,
      selectedCategoryIndex: index,
    ));

    try {
      final categoryId = state.categories[index].id;
      final products = await _service.getProducts(categoryId: categoryId);

      emit(state.copyWith(
        status: ProductsStatus.success,
        products: products,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(
        status: ProductsStatus.failure,
        errorMessage: e.message,
      ));
    }
  }
}
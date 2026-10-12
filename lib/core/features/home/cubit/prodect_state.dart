import 'package:equatable/equatable.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  final List<Category> categories;
  final int selectedCategoryIndex;
  final String errorMessage;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.selectedCategoryIndex = 0,
    this.errorMessage = '',
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    List<Category>? categories,
    int? selectedCategoryIndex,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, products, categories, selectedCategoryIndex, errorMessage];
}
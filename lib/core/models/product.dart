import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<Color> colors;
  final List<String> sizes;
  final int? categoryId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.colors = const [Colors.black, Colors.white, Colors.grey],
    this.sizes = const ['S', 'M', 'L', 'XL'],
    this.categoryId,
  });

  // الـ API مش بيرجّع colors/sizes، فبنحط قيم افتراضية
  factory Product.fromJson(Map<String, dynamic> json) {
    final images = (json['images'] as List?) ?? [];
    final firstImage =
    images.isNotEmpty ? _cleanUrl(images.first.toString()) : '';

    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: firstImage.isNotEmpty
          ? firstImage
          : 'https://picsum.photos/seed/${json['id']}/300/300',
      categoryId: json['category']?['id'],
    );
  }

  // بعض صور الـ API بترجع بالشكل ["https://..."] فبنشيل الأقواس والعلامات
  static String _cleanUrl(String url) =>
      url.replaceAll(RegExp(r'[\[\]"]'), '').trim();
}
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  final Color selectedColor;
  final String selectedSize;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.selectedColor,
    required this.selectedSize,
  });

  CartItem copyWith({int? quantity}) => CartItem(
    product: product,
    quantity: quantity ?? this.quantity,
    selectedColor: selectedColor,
    selectedSize: selectedSize,
  );

  double get totalPrice => product.price * quantity;

  @override
  List<Object?> get props => [product.id, quantity, selectedColor, selectedSize];
}
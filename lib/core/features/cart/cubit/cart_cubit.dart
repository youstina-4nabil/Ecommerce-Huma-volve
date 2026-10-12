import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/cart_item.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super(const []);

  // إضافة منتج
  void addItem(CartItem item) {
    final index = state.indexWhere((i) =>
    i.product.id == item.product.id &&
        i.selectedColor == item.selectedColor &&
        i.selectedSize == item.selectedSize);

    if (index >= 0) {
      final updated = [...state];
      updated[index] = updated[index]
          .copyWith(quantity: updated[index].quantity + item.quantity);
      emit(updated);
    } else {
      emit([...state, item]);
    }
  }

  void increment(int index) {
    final updated = [...state];
    updated[index] = updated[index]
        .copyWith(quantity: updated[index].quantity + 1);
    emit(updated);
  }

  void decrement(int index) {
    final updated = [...state];
    if (updated[index].quantity > 1) {
      updated[index] = updated[index]
          .copyWith(quantity: updated[index].quantity - 1);
    } else {
      updated.removeAt(index);
    }
    emit(updated);
  }

  void removeAt(int index) {
    final updated = [...state]..removeAt(index);
    emit(updated);
  }

  void clear() => emit(const []);

  // حسابات
  double get subtotal =>
      state.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.1;
  double get total => subtotal + tax;
  int get itemCount =>
      state.fold(0, (sum, item) => sum + item.quantity);
}
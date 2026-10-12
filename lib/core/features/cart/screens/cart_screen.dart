import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../models/cart_item.dart';
import '../../../theme.dart';

import '../cubit/cart_cubit.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, items) {
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          final cubit = context.read<CartCubit>();
          final subtotal = cubit.subtotal;
          final tax = cubit.tax;
          final total = cubit.total;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) => CartItemCard(
                    cartItem: items[index],
                    onIncrement: () => cubit.increment(index),
                    onDecrement: () => cubit.decrement(index),
                  ),
                ),
              ),
              // ... نفس الـ bottom summary ...
            ],
          );
        },
      ),
    );
  }
}

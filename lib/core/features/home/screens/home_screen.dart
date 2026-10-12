import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../dummy_data.dart';
import '../../../theme.dart';
import '../cubit/prodect_cubit.dart';
import '../cubit/prodect_state.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state.status == ProductsStatus.loading &&
                state.products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ProductsStatus.failure &&
                state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMessage),
                    TextButton(
                      onPressed: () =>
                          context.read<ProductsCubit>().loadData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ... هيدر ...
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 44,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            separatorBuilder: (_, __) =>
                            const SizedBox(width: 12),
                            itemBuilder: (context, index) => CategoryChip(
                              label: state.categories[index].name,
                              isSelected:
                              state.selectedCategoryIndex == index,
                              onTap: () => context
                                  .read<ProductsCubit>()
                                  .selectCategory(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                          ProductCard(product: state.products[index]),
                      childCount: state.products.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
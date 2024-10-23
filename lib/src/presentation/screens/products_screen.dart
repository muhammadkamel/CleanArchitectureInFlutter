import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CartSummary(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(RefreshProductsEvent());
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.maybeMap(
              loading: (state) {
                final dummyData = List.generate(
                  5,
                  (index) => ProductEntity(
                    id: 3,
                    title: 'title',
                    price: 33.3,
                    description: 'description',
                    category: 'category',
                    image: 'image',
                    rating: RatingEntity(count: 0, rate: 0.0),
                  ),
                );
                return Skeletonizer(
                  child: ProductsListWidget(
                    products: dummyData,
                  ),
                );
              },
              failure: (state) {
                return Center(
                  child: Text(state.message.toString()),
                );
              },
              orElse: (state) {
                final products = state.products;
                if (products == null || products.isEmpty) {
                  return EmptyProductsWidget();
                }
                return ProductsListWidget(
                  products: products,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.cart == null) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.all(Spacing.medium),
          child: FilledButton.icon(
            onPressed: () {
              context.read<ManageBottomNavBloc>().add(UpdateIndexEvent(1));
            },
            label: const Text("Checkout"),
            icon: Text("Total: ${state.cart?.total}"),
          ),
        );
      },
    );
  }
}

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.medium,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No data found",
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(Spacing.large),
          FilledButton(
            onPressed: () {
              context.read<ProductBloc>().add(GetProductsEvent());
            },
            child: Text("Try again"),
          ),
        ],
      ),
    );
  }
}

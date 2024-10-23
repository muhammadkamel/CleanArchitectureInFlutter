import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.maybeMap(
              loading: (_) {
                final dummyProduct = ProductEntity(
                  id: 3,
                  title: 'title',
                  price: 33.3,
                  description: 'description' * 20,
                  category: 'category',
                  image: 'image',
                  rating: RatingEntity(count: 0, rate: 0.0),
                );
                return Skeletonizer(
                  child: ProductDetailsBody(product: dummyProduct),
                );
              },
              orElse: (state) {
                final product = state.product;
                if (product == null) {
                  return SizedBox();
                }
                return ProductDetailsBody(product: product);
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.medium,
              vertical: Spacing.large,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (_, __) => Image.asset(Assets.placeholder),
                  errorWidget: (_, __, ___) => Image.asset(Assets.placeholder),
                  height: 200,
                ),
                Gap(Spacing.xLarge),
                Text(
                  product.title,
                  style: context.titleLarge,
                ),
                Divider(),
                Text(
                  product.description,
                  style: context.bodyLarge.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                Gap(Spacing.xLarge),

                /// TODO: Add rating widget
                RatingWidget(
                  rating: product.rating.rate,
                  count: product.rating.count,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.medium,
            vertical: Spacing.small,
          ),
          child: FilledButton(
            onPressed: () {
              context.read<CartBloc>().add(
                    AddToCartEvent(
                      CartItemEntity(productId: product.id, quantity: 1),
                    ),
                  );
            },
            child: Text('Add to cart'),
          ),
        ),
      ],
    );
  }
}

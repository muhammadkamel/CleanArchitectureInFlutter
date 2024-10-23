import 'package:flutter/material.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/screens/widgets/product_card_widget.dart';

class ProductsListWidget extends StatelessWidget {
  const ProductsListWidget({
    super.key,
    required this.products,
  });

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(
        left: Spacing.medium,
        right: Spacing.medium,
        bottom: Spacing.xLarge * 3,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCardWidget(product: product);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: products.length,
    );
  }
}

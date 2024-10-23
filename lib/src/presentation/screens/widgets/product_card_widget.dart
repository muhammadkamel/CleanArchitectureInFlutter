import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final ratingCount = product.rating.count;
    final rating = product.rating.rate;

    return InkWell(
      onTap: () {
        context.pushNamed(
          "ProductDetailsScreen",
          pathParameters: {'productId': product.id.toString()},
        );
      },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: EdgeInsets.all(Spacing.medium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: product.image,
              errorWidget: (context, url, error) {
                return ProductImageWidget(
                  imageProvider: const AssetImage(Assets.placeholder),
                );
              },
              placeholder: (context, url) {
                return ProductImageWidget(
                  imageProvider: AssetImage(Assets.placeholder),
                );
              },
              imageBuilder: (context, imageProvider) {
                return ProductImageWidget(
                  imageProvider: imageProvider,
                );
              },
            ),
            Gap(Spacing.medium),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: context.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  /// Rating
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: context.bodySmall,
                          children: [
                            TextSpan(
                              text: rating.toString(),
                            ),
                            TextSpan(
                              text: " ($ratingCount)",
                            ),
                          ],
                        ),
                      ),
                      Gap(6),
                      const Icon(
                        FluentIcons.star_20_filled,
                        color: Colors.amber,
                      ),
                    ],
                  ),

                  /// Price
                  Text(
                    "${product.price} \$",
                    style: context.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Gap(Spacing.medium),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: context.colorScheme.onPrimary,
                        backgroundColor: context.colorScheme.primary,
                      ),
                      onPressed: () {
                        context.read<CartBloc>().add(
                              AddToCartEvent(
                                CartItemEntity(
                                  productId: product.id,
                                  price: product.price,
                                  description: product.description,
                                  imageUrl: product.image,
                                  name: product.title,
                                  quantity: 1,
                                ),
                              ),
                            );
                      },
                      icon: const Icon(FluentIcons.add_20_filled),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

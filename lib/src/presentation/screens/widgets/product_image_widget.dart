import 'package:flutter/material.dart';
import 'package:oth_app/src/core/core.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.imageProvider,
  });
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

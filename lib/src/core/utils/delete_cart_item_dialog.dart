import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/cart_item_entity.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class DeleteCartItemDialog extends StatelessWidget {
  const DeleteCartItemDialog({
    super.key,
    required this.product,
  });

  final CartItemEntity product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete product',
        style: context.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text('Are you sure you want to delete this product?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            context.read<CartBloc>().add(
                  RemoveFromCartEvent(product),
                );
            context.pop();
          },
        ),
      ],
    );
  }
}

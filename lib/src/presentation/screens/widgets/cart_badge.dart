import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {},
          icon: Badge.count(
            count: state.cart?.products.length ?? 0,
            child: const Icon(FluentIcons.cart_20_filled),
          ),
        );
      },
    );
  }
}

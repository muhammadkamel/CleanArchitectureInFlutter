import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.maybeMap(
            success: (state) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.medium,
                  vertical: Spacing.large,
                ),
                itemBuilder: (context, index) {
                  final product = state.cart?.products[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(product?.name ?? ""),
                          trailing: IconButton(
                            icon: const Icon(FluentIcons.delete_20_filled),
                            onPressed: () {
                              if (product == null) {
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<CartBloc>(),
                                    child:
                                        DeleteCartItemDialog(product: product),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        /// Update quantity
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(
                            width: 130,
                            alignment: AlignmentDirectional.centerEnd,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(16),
                              color:
                                  context.primaryColor.withValues(alpha: 0.1),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withValues(alpha: 0.1),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        FluentIcons.subtract_20_filled),
                                  ),
                                  Text(
                                    product?.quantity.toString() ?? "",
                                    style: context.bodyLarge,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(FluentIcons.add_20_filled),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.cart?.products.length ?? 0,
              );
            },
            orElse: (state) {
              return const Center();
            },
          );
        },
      ),
    );
  }
}

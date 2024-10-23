import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class RetryFetchProductWidget extends StatelessWidget {
  const RetryFetchProductWidget({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.medium,
        vertical: Spacing.large,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "No data found",
              style: context.titleLarge,
            ),
          ),
          Gap(Spacing.large),
          FilledButton(
            onPressed: () {
              context.read<ProductBloc>().add(
                    GetProductByIdEvent(productId: productId),
                  );
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

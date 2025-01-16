import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:oth_app/src/core/core.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
    required this.count,
  });

  final double rating;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.medium,
          vertical: Spacing.medium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rating: ",
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(
                  FluentIcons.star_20_filled,
                  color: Colors.amber,
                ),
                Gap(Spacing.small),
                RichText(
                  text: TextSpan(
                    text: "$rating ",
                    style: context.bodyMedium,
                    children: [
                      TextSpan(
                        text: "($count)",
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface
                              .withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

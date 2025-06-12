import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class ExpandedListWidget extends StatelessWidget {
  const ExpandedListWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: TapToExpand(
        backgroundcolor: theme.cardColor,
        iconColor: theme.iconTheme.color,
        outerClosedPadding: 0,
        outerOpenedPadding: 0,
        openedHeight: 150,
        borderRadius: const BorderRadius.all(Radius.zero),
        title: Expanded(
          child: Text(
            title,
            style: AppStyles.font14Regular.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        content: Text(
          content,
          style: AppStyles.font10Regular.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

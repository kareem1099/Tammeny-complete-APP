import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: theme.brightness == Brightness.dark
              ? theme.colorScheme.secondary.withOpacity(0.1)
              : const Color(0xffE9FAEF),
          child: SvgPicture.asset(Assets.imagesCalendarCompletedIcon),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).scanAnalysisCompleted,
                style: AppStyles.font14SemiBold.copyWith(
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                S.of(context).scanAnalysisMessage,
                style: AppStyles.font12Regular.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        Text(
          '1${S.of(context).hoursShort}',
          style: AppStyles.font10Regular.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        )
      ],
    );
  }
}

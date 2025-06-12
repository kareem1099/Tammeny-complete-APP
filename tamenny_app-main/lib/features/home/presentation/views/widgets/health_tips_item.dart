import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/features/home/domain/entites/health_tip_entity.dart';

class HealthTipsItem extends StatelessWidget {
  const HealthTipsItem({
    super.key,
    required this.healthTipEntity,
  });

  final HealthTipEntity healthTipEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.white
                    .withOpacity(0.05) // subtle light shadow for dark mode
                : Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              healthTipEntity.icon,
              color: AppColors.primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            healthTipEntity.tip,
            style: TextStyle(
              fontSize: 13,
              color:
                  isDark ? theme.textTheme.bodyMedium?.color : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

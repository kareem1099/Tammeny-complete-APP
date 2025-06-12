import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_item.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<ProfileItem> items;

  const ProfileSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.font13Bold.copyWith(
              color: theme.textTheme.bodyMedium?.color ?? Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => item),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class RecentSearchHeader extends StatelessWidget {
  const RecentSearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Search',
          style: AppStyles.font18SemiBold,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Clear All History',
            style: AppStyles.font12Regular.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

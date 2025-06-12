import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';
import '../../../../../core/theme/app_styles.dart';

class HealthScanCategoriesHeaderWidget extends StatelessWidget {
  const HealthScanCategoriesHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).healthScanCategories,
          style: AppStyles.font18SemiBold,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Text(
          text,
          style: AppStyles.font16Bold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

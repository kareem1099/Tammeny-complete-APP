import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.bgColor,
      this.textColor});
  final String text;
  final VoidCallback onTap;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.font16SemiBold
                .copyWith(color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}

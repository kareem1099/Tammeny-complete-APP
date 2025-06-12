import 'package:flutter/material.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.forgotPasswordView,
          );
        },
        child: Text(
          S.of(context).forgotPassword,
          style: AppStyles.font12Regular.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

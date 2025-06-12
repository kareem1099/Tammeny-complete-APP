import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/theme/app_styles.dart';

class TermsAndConditionsAndPrivacyPolicy extends StatelessWidget {
  const TermsAndConditionsAndPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use the theme's text styles and colors
    final secondaryTextColor =
        theme.textTheme.bodyMedium?.color ?? const Color(0xff9E9E9E);
    final primaryTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: S.of(context).agreeLogging,
            style: AppStyles.font12Regular.copyWith(
              color: secondaryTextColor,
            ),
          ),
          TextSpan(
            text: S.of(context).termsAndConditions,
            style: AppStyles.font14Medium.copyWith(
              color: primaryTextColor,
            ),
          ),
          TextSpan(
            text: S.of(context).and,
            style: AppStyles.font12Regular.copyWith(
              color: secondaryTextColor,
            ),
          ),
          TextSpan(
            text: S.of(context).privacyPolicy,
            style: AppStyles.font14Medium.copyWith(
              color: primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

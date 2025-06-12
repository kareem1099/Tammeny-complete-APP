import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/generated/l10n.dart';

class UnreadNoitifications extends StatelessWidget {
  const UnreadNoitifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 7),
          child: Text(
            '2 ${S.of(context).New}',
            style: AppStyles.font8Medium.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

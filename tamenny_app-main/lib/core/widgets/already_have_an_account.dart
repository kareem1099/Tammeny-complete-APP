import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../routes/routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).alreadyHaveAccount,
          style: AppStyles.font11Regular,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.loginView);
          },
          child: Text(
            S.of(context).signIn,
            style: AppStyles.font11Regular.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

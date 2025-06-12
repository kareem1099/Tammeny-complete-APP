import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../routes/routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).noAccount,
          style: AppStyles.font11Regular,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.signupView);
          },
          child: Text(
            S.of(context).createOne,
            style: AppStyles.font11Regular.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

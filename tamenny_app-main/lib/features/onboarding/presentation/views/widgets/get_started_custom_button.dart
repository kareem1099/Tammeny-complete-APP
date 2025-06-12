import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.onboardingView);
        },
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(1000)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).getStarted,
                    style: AppStyles.font18ExtraBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SvgPicture.asset(
                    Assets.imagesArrowIcon,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

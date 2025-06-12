import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';

class HeaderLogoWelcomeView extends StatelessWidget {
  const HeaderLogoWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15555),
        ),
        child: Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              Assets.imagesLogo,
            ),
          ),
        ),
      ),
    );
  }
}

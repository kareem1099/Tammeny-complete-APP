import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/login_custom_clipper.dart';

class CustomClipPathWithLogo extends StatelessWidget {
  const CustomClipPathWithLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomLogoClipper(),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.15,
        width: double.infinity,
        color: AppColors.primaryColor,
        child: Center(
          child: SvgPicture.asset(
            Assets.imagesLogoWhite,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/splash/presentation/views/widgets/logo_name_with_animation.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: SvgPicture.asset(
              Assets.imagesLogo,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const LogoNameWithAnimation(),
        ],
      ),
    );
  }
}

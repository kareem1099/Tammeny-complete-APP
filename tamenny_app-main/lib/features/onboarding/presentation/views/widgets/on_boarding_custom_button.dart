import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamenny_app/config/cache_helper.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';

class CustomOnboardingButton extends StatelessWidget {
  const CustomOnboardingButton(
      {super.key, required this.controller, required this.currentPage});
  final PageController controller;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (currentPage == 2) {
          CacheHelper.set(key: 'isOnboardingVisited', value: true);
          Navigator.pushReplacementNamed(context, Routes.signupView);
        } else {
          controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn);
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(500)),
        child: Center(
          child: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(Assets.imagesArrowSmIcon)),
        ),
      ),
    );
  }
}

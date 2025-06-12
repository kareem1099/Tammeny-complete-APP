import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/widgets/step_image_widget.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/widgets/step_widget.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entites/on_boarding_entity.dart';

class OnBoardingPageViewBody extends StatefulWidget {
  const OnBoardingPageViewBody({
    super.key,
    required this.controller,
    required this.onBoardingEntity,
  });
  final PageController controller;
  final OnBoardingEntity onBoardingEntity;

  @override
  State<OnBoardingPageViewBody> createState() => _OnBoardingPageViewBodyState();
}

class _OnBoardingPageViewBodyState extends State<OnBoardingPageViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: StepWidget(text: widget.onBoardingEntity.numberOfStep),
        ),
        StepImageWidget(imageUrl: widget.onBoardingEntity.image),
        const SizedBox(
          height: 60,
        ),
        SmoothPageIndicator(
          controller: widget.controller,
          count: 3,
          axisDirection: Axis.horizontal,
          effect: WormEffect(
            dotColor: AppColors.primaryColor.withOpacity(0.25),
            activeDotColor: AppColors.primaryColor,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            widget.onBoardingEntity.textDesc,
            textAlign: TextAlign.center,
            style: AppStyles.font30ExtraBold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

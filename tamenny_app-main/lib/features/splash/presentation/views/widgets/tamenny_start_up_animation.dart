import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class TammenyStartupAnimation extends StatelessWidget {
  const TammenyStartupAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: false,
      totalRepeatCount: 1,
      animatedTexts: [
        TyperAnimatedText(
          'Tamenny',
          textStyle: AppStyles.font32Bold.copyWith(
            color: AppColors.blueDarkColor,
          ),
          speed: const Duration(
            milliseconds: 100,
          ),
        ),
      ],
    );
  }
}

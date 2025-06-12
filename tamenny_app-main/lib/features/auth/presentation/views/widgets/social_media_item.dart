import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';

class SocialMediaItem extends StatelessWidget {
  const SocialMediaItem({
    super.key,
    required this.onTap,
    required this.socialMediaImageSource,
  });

  final VoidCallback onTap;
  final String socialMediaImageSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.brightness == Brightness.dark
        ? AppColors.darkCardColor
        : const Color(0xffF5F5F5);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: SizedBox(
            height: 27,
            width: 27,
            child: SvgPicture.asset(
              socialMediaImageSource,
            ),
          ),
        ),
      ),
    );
  }
}

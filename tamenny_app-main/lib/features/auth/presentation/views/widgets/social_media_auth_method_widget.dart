import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class SocialMediaAuthMethodWidget extends StatelessWidget {
  const SocialMediaAuthMethodWidget({
    super.key,
    required this.iconImage,
    required this.text,
    required this.onPressed,
  });
  final String iconImage;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xffDDDFDF)),
        ),
      ),
      onPressed: onPressed,
      child: ListTile(
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
        ),
        leading: SvgPicture.asset(iconImage),
        title: Text(
          text,
          style: AppStyles.font18SemiBold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

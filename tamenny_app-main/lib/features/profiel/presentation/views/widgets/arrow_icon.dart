import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';

class ArrowIcon extends StatelessWidget {
  const ArrowIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final iconColor = theme.brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey;

    return Transform.rotate(
      angle: isArabic ? 3.1416 : 0,
      child: SvgPicture.asset(
        Assets.imagesProfileArrowGoIcon,
        width: 12,
        height: 12,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}

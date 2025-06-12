import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CircleAvatar(
      radius: 24,
      backgroundColor: isDark
          ? theme.cardColor.withOpacity(0.3)
          : const Color(0xffF5F5F5), // original light bg
      child: SvgPicture.asset(
        Assets.imagesNotificationFoundIcon,
        // colorFilter: ColorFilter.mode(
        //   isDark ? Colors.white70 : Colors.transparent,
        //   BlendMode.srcIn,
        // ),
      ),
    );
  }
}

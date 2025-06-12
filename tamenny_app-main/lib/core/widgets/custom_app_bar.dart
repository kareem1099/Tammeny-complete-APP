import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_styles.dart';
import '../utils/app_assets.dart';

AppBar customAppBar(
  BuildContext context, {
  required String title,
  List<Widget>? actions,
  bool leadingIcon = true,
  Color? backgroundColor,
  Color? titleColor,
}) {
  final theme = Theme.of(context);
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
    surfaceTintColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    leading: leadingIcon
        ? GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Transform.rotate(
                angle: isArabic ? 180 * math.pi / 180 : 0,
                child: SvgPicture.asset(
                  Assets.imagesPopIcon,
                  width: 30,
                  height: 30,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          )
        : null,
    title: Text(
      title,
      style: AppStyles.font18SemiBold.copyWith(
        color: titleColor ?? theme.textTheme.bodyLarge?.color,
      ),
    ),
    actions: actions,
  );
}

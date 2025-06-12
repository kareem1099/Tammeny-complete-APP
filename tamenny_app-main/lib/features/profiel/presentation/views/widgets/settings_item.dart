import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      this.leadingIcon,
      required this.title,
      required this.onTap,
      this.titleColor,
      this.trailingIcon});
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  leadingIcon ?? const SizedBox(),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: AppStyles.font14Regular.copyWith(
                              color: titleColor ?? const Color(0xff242424)),
                        ),
                        trailingIcon ??
                            SvgPicture.asset(Assets.imagesGoArrowRigthIcon),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/arrow_icon.dart';

class ProfileItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailingWidget;

  const ProfileItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: Center(child: SvgPicture.asset(iconPath))),
                  const SizedBox(width: 12),
                  Text(title, style: AppStyles.font16Medium),
                ],
              ),
              trailingWidget ?? const ArrowIcon(),
            ],
          ),
        ),
      ),
    );
  }
}

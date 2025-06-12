import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/generated/l10n.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color borderColor = isDark ? theme.cardColor : Colors.white;
    Color fillColor = isDark ? theme.cardColor : Colors.white;
    Color hintColor = isDark ? Colors.grey.shade400 : const Color(0xff949D9E);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.6)
                : const Color(0x0A000000),
            blurRadius: 9,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 20,
            child: Center(
                child: SvgPicture.asset(Assets.imagesSearchIcon,
                    colorFilter: ColorFilter.mode(
                        isDark ? Colors.white70 : Colors.black54,
                        BlendMode.srcIn))),
          ),
          suffixIcon: SizedBox(
            width: 20,
            child: Center(
                child: SvgPicture.asset(Assets.imagesFilterIcon,
                    colorFilter: ColorFilter.mode(
                        isDark ? Colors.white70 : Colors.black54,
                        BlendMode.srcIn))),
          ),
          hintText: S.of(context).search,
          hintStyle: AppStyles.font12Regular.copyWith(color: hintColor),
          fillColor: fillColor,
          filled: true,
          border: buildBorder(borderColor),
          enabledBorder: buildBorder(borderColor),
          focusedBorder: buildBorder(borderColor),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.validate,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSaved,
    this.controller,
    this.fillColor,
    this.borderColor,
    this.hintStyle,
    this.textColor,
  });

  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  final bool obscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String?)? onSaved;
  final TextEditingController? controller;

  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultFillColor = fillColor ??
        (theme.brightness == Brightness.dark
            ? AppColors.darkCardColor
            : AppColors.grayColor);

    final defaultBorderColor = borderColor ??
        (theme.brightness == Brightness.dark
            ? AppColors.darkDividerColor
            : AppColors.deepGrayColor);

    final defaultHintStyle = hintStyle ??
        AppStyles.font14Medium.copyWith(
          color: theme.brightness == Brightness.dark
              ? AppColors.darkSecondaryTextColor
              : const Color(0xffC2C2C2),
        );

    final defaultTextColor = textColor ??
        (theme.brightness == Brightness.dark
            ? AppColors.darkTextColor
            : Colors.black87);

    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validate,
      obscureText: obscure,
      style: AppStyles.font14Medium.copyWith(color: defaultTextColor),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: defaultHintStyle,
        fillColor: defaultFillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: defaultBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: defaultBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: defaultBorderColor),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamenny_app/config/locale_notifier.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/generated/l10n.dart';

void showLanguagePicker(BuildContext context,
    {required String currentLanguage}) {
  final localeNotifier = Provider.of<LocaleNotifier>(context, listen: false);
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  // اختار الألوان حسب الثيم
  final backgroundColor =
      isDark ? AppColors.darkCardColor : theme.colorScheme.surface;
  final onSurfaceColor =
      isDark ? AppColors.darkTextColor : theme.colorScheme.onSurface;
  final primaryColor =
      isDark ? AppColors.darkPrimaryColor : theme.colorScheme.primary;
  final outlineColor =
      isDark ? AppColors.darkDividerColor : theme.colorScheme.outline;
  final surfaceVariantColor = isDark
      ? AppColors.darkBackgroundColor
      : theme.colorScheme.surfaceContainerHighest;
  final onSurfaceVariantColor = isDark
      ? AppColors.darkSecondaryTextColor
      : theme.colorScheme.onSurfaceVariant;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: backgroundColor,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: onSurfaceColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).chooseLanguage,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: onSurfaceColor,
              ),
            ),
            const SizedBox(height: 20),
            _buildLanguageOption(
              context: context,
              label: 'English',
              isSelected: currentLanguage == 'en',
              onTap: () {
                if (currentLanguage != 'en') {
                  localeNotifier.setLocale(const Locale('en'));
                }
                log(localeNotifier.locale.toString());
                Navigator.pop(context);
              },
              primaryColor: primaryColor,
              onSurfaceColor: onSurfaceColor,
              outlineColor: outlineColor,
              surfaceVariantColor: surfaceVariantColor,
              onSurfaceVariantColor: onSurfaceVariantColor,
              isDark: isDark,
            ),
            const SizedBox(height: 8),
            _buildLanguageOption(
              context: context,
              label: 'العربية',
              isSelected: currentLanguage == 'ar',
              onTap: () {
                if (currentLanguage != 'ar') {
                  localeNotifier.setLocale(const Locale('ar'));
                }
                log(localeNotifier.locale.toString());
                Navigator.pop(context);
              },
              primaryColor: primaryColor,
              onSurfaceColor: onSurfaceColor,
              outlineColor: outlineColor,
              surfaceVariantColor: surfaceVariantColor,
              onSurfaceVariantColor: onSurfaceVariantColor,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

Widget _buildLanguageOption({
  required BuildContext context,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
  required Color primaryColor,
  required Color onSurfaceColor,
  required Color outlineColor,
  required Color surfaceVariantColor,
  required Color onSurfaceVariantColor,
  required bool isDark,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isSelected ? primaryColor.withOpacity(0.15) : surfaceVariantColor,
        border: Border.all(
          color: isSelected ? primaryColor : outlineColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? primaryColor : onSurfaceVariantColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
          height: 1.3,
          fontFamily:
              isDark ? 'YourDarkModeFont' : null, // لو عندك فونت خاص للدارك
        ),
        textAlign: TextAlign.start,
      ),
    ),
  );
}

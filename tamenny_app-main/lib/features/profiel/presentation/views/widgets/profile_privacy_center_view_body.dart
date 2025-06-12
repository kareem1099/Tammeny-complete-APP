import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ProfilePrivacyCenterViewBody extends StatelessWidget {
  const ProfilePrivacyCenterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    final theme = Theme.of(context);
    final primaryTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secondaryTextColor =
        theme.textTheme.bodyMedium?.color ?? Colors.black87;
    final hintTextColor = theme.hintColor.withOpacity(0.6);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locale.privacyMattersTitle,
              style: AppStyles.font20SemiBold.copyWith(color: primaryTextColor),
            ),
            const SizedBox(height: 12),
            Text(
              locale.privacyIntroText,
              style:
                  AppStyles.font16Regular.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, locale.whatWeCollectTitle),
            _sectionBody(context, [
              locale.whatWeCollectItem1,
              locale.whatWeCollectItem2,
              locale.whatWeCollectItem3,
            ]),
            Text(
              locale.noSensitiveDataNote,
              style: AppStyles.font16Regular.copyWith(color: hintTextColor),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, locale.howWeUseDataTitle),
            _sectionBody(context, [
              locale.howWeUseDataItem1,
              locale.howWeUseDataItem2,
              locale.howWeUseDataItem3,
            ]),
            Text(
              locale.noAdsOrSellingNote,
              style: AppStyles.font16Regular.copyWith(color: hintTextColor),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, locale.thirdPartyServicesTitle),
            Text(
              locale.thirdPartyServicesDescription,
              style:
                  AppStyles.font16Regular.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, locale.yourControlsTitle),
            _sectionBody(context, [
              locale.yourControlsItem1,
              locale.yourControlsItem2,
              locale.yourControlsItem3,
            ]),
            Text(
              locale.transparencyNote,
              style: AppStyles.font16Regular.copyWith(color: hintTextColor),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, locale.contactUsTitle),
            Text(
              locale.contactUsDescription,
              style:
                  AppStyles.font16Regular.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) {
    final theme = Theme.of(context);
    final titleColor = theme.textTheme.titleLarge?.color ?? Colors.black;
    return Text(
      text,
      style: AppStyles.font18SemiBold.copyWith(color: titleColor),
    );
  }

  Widget _sectionBody(BuildContext context, List<String> items) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black87;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: items
            .map((item) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        item,
                        style:
                            AppStyles.font16Regular.copyWith(color: textColor),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

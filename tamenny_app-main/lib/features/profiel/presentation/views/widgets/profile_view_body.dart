import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:tamenny_app/config/locale_notifier.dart';
import 'package:tamenny_app/config/theme_notifier.dart';
import 'package:tamenny_app/core/functions/show_language_picker.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_header.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_item.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_section.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/signout_button.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeNotifier = Provider.of<LocaleNotifier>(context, listen: false);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const ProfileHeader(),
          const SizedBox(height: 24),
          ProfileSection(
            title: S.of(context).account,
            items: [
              ProfileItem(
                iconPath: Assets.imagesProfileDataIcon,
                title: S.of(context).profileDataTitle,
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(Routes.personalInfoView),
              ),
              ProfileItem(
                iconPath: Assets.imagesChangePasswordIcon,
                title: S.of(context).changePassword,
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(Routes.profileChangePasswordView),
              ),
            ],
          ),

          // PREFERENCE
          ProfileSection(
            title: S.of(context).preference,
            items: [
              ProfileItem(
                iconPath: Assets.imagesDarkModeIcon,
                title: S.of(context).darkMode,
                trailingWidget: SizedBox(
                  width: 60,
                  height: 30,
                  child: Center(
                    child: FlutterSwitch(
                      value: themeNotifier.isDark,
                      onToggle: (val) {
                        themeNotifier.toggleTheme();
                      },
                      activeColor: Colors.black87,
                      inactiveColor: Colors.grey.shade300,
                      toggleColor: Colors.grey.shade100,
                      activeIcon:
                          const Icon(Icons.dark_mode, color: Colors.amber),
                      inactiveIcon:
                          const Icon(Icons.light_mode, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              ProfileItem(
                iconPath: Assets.imagesLanguageIcon,
                title: S.of(context).language,
                onTap: () {
                  showLanguagePicker(context,
                      currentLanguage: localeNotifier.locale.toString());
                },
              ),
            ],
          ),

          // HELP
          ProfileSection(
            title: S.of(context).help,
            items: [
              ProfileItem(
                iconPath: Assets.imagesQuestionIcon,
                title: S.of(context).faq,
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(Routes.profileFaqView),
              ),
              ProfileItem(
                iconPath: Assets.imagesPrivacyIcon,
                title: S.of(context).privacyPolicy,
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(Routes.profilePrivacyCenterApp),
              ),
            ],
          ),
          const SignOutButton(),
        ],
      ),
    );
  }
}

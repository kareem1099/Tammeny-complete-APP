import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_privacy_center_view_body.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ProfilePrivacyCenterView extends StatelessWidget {
  const ProfilePrivacyCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: S.of(context).privacyCenterTitle),
      body: const ProfilePrivacyCenterViewBody(),
    );
  }
}

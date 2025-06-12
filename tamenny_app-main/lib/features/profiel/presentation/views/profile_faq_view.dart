import 'package:flutter/material.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_faq_view_body.dart';
import 'package:tamenny_app/generated/l10n.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ProfileFaqView extends StatelessWidget {
  const ProfileFaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: S.of(context).faq),
      body: const ProfileFaqViewBody(),
    );
  }
}

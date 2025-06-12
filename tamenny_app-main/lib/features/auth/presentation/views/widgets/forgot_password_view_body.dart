import 'package:flutter/material.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/custom_clip_path_with_logo.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/forgot_password_form_section.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomClipPathWithLogo(),
        Expanded(child: ForgotPasswordFormSection()),
      ],
    );
  }
}

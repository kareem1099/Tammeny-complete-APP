import 'package:flutter/material.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/custom_clip_path_with_logo.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/signup_form_section.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CustomClipPathWithLogo(),
        SignUpFormSection(),
      ],
    );
  }
}

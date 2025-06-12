import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/password__text_field.dart';
import 'package:tamenny_app/features/profiel/presentation/manager/cubit/change_password_cubit.dart';
import 'package:tamenny_app/generated/l10n.dart';
// Import localization class (adjust import path based on your project setup)

class ProfileChangePasswordViewBody extends StatefulWidget {
  const ProfileChangePasswordViewBody({super.key});

  @override
  State<ProfileChangePasswordViewBody> createState() =>
      _ProfileChangePasswordViewBodyState();
}

class _ProfileChangePasswordViewBodyState
    extends State<ProfileChangePasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(loc.currentPassword, style: AppStyles.font16Medium),
            const SizedBox(height: 8),
            PasswordTextField(controller: currentPasswordController),
            const SizedBox(height: 16),
            Text(loc.newPassword, style: AppStyles.font16Medium),
            const SizedBox(height: 8),
            PasswordTextField(controller: newPasswordController),
            const SizedBox(height: 16),
            Text(loc.confirmNewPassword, style: AppStyles.font16Medium),
            const SizedBox(height: 8),
            PasswordTextField(controller: confirmPasswordController),
            const SizedBox(height: 32),
            CustomAppButton(
              text: loc.updatePassword,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  final enteredPassword = currentPasswordController.text;
                  final newPassword = newPasswordController.text;
                  final confirmPassword = confirmPasswordController.text;

                  if (newPassword != confirmPassword) {
                    showErrorBar(context, message: loc.passwordMismatchError);
                    return;
                  }

                  context.read<ChangePasswordCubit>().changePassword(
                        enteredPassword: enteredPassword,
                        newPassword: newPassword,
                      );
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

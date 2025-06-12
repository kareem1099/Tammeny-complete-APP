import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/core/functions/validator.dart';
import 'package:tamenny_app/features/auth/presentation/manager/cubit/forgot_password_cubit.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/custom_app_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class ForgotPasswordFormSection extends StatefulWidget {
  const ForgotPasswordFormSection({super.key});

  @override
  State<ForgotPasswordFormSection> createState() =>
      _ForgotPasswordFormSectionState();
}

class _ForgotPasswordFormSectionState extends State<ForgotPasswordFormSection> {
  late String email;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            Text(
              'Forgot Password',
              style: AppStyles.font24Bold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'At our app, we take the security of your information seriously.',
              style: AppStyles.font14Regular.copyWith(
                color: const Color(0xff757575),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextFormField(
              hintText: 'Email or Phone Number',
              validate: Validator.validateEmail,
              onSaved: (data) {
                email = data!;
              },
            ),
            const Expanded(
              child: SizedBox(),
            ),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                if (state is ForgotPasswordLoading) {
                  return const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  );
                }
                return CustomAppButton(
                  text: 'Reset Password',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context
                          .read<ForgotPasswordCubit>()
                          .forgotPassword(email: email);
                      showErrorBar(context,
                          message: 'Check your email for the reset link.');
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 26,
            ),
          ],
        ),
      ),
    );
  }
}

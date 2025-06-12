import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/functions/validator.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/password__text_field.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/already_have_an_account.dart';
import '../../../../../core/widgets/custom_app_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({super.key});

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObsecure = true;
  bool isTermsAndConditionsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showErrorBar(context,
              message: 'Your account has been successfully created.');
          Navigator.pushReplacementNamed(context, Routes.loginView);
        } else if (state is SignupFailure) {
          showErrorBar(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
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
                  S.of(context).createAccount,
                  style: AppStyles.font24Bold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hintText: S.of(context).fullName,
                  onSaved: (data) {
                    name = data!;
                  },
                  validate: Validator.validateFullName,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: S.of(context).email,
                  onSaved: (data) {
                    email = data!;
                  },
                  validate: Validator.validateEmail,
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordTextField(
                  onSaved: (data) {
                    password = data!;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                state is SignupLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : CustomAppButton(
                        text: S.of(context).createAccount,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context
                                .read<SignupCubit>()
                                .createUserWithEmailAndPassword(
                                    name: name,
                                    email: email,
                                    password: password);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
                const SizedBox(
                  height: 46,
                ),
                const TermsAndConditionsAndPrivacyPolicy(),
                const SizedBox(
                  height: 24,
                ),
                const AlreadyHaveAnAccount(),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/core/functions/validator.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/password__text_field.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/forgot_password_widget.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/custom_app_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/dont_have_an_account.dart';
import 'or_sign_in_with.dart';
import 'social_media_methods.dart';

class SigninFormSection extends StatefulWidget {
  const SigninFormSection({super.key});

  @override
  State<SigninFormSection> createState() => _SigninFormSectionState();
}

class _SigninFormSectionState extends State<SigninFormSection> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          showErrorBar(context, message: 'تم تسجيل الدخول بنجاح');
          Navigator.pushReplacementNamed(context, Routes.bottomNavBarView);
        } else if (state is SignInFailure) {
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
                  S.of(context).welcomeBack,
                  style: AppStyles.font24Bold
                      .copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 30,
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
                const ForgotPasswordWidget(),
                const SizedBox(
                  height: 32,
                ),
                state is SignInSuccess
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : CustomAppButton(
                        text: S.of(context).login,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context
                                .read<SigninCubit>()
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
                const SizedBox(
                  height: 32,
                ),
                const DontHaveAnAccount(),
                const SizedBox(
                  height: 32,
                ),
                const OrSignInWith(),
                const SizedBox(
                  height: 32,
                ),
                const SocialMediaMethods(),
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

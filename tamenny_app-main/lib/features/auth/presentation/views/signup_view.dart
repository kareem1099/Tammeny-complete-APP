import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/features/auth/domain/repos/auth_repo.dart';
import 'package:tamenny_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/signup_view_body.dart';
import '../../../../core/theme/app_colors.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: isDark ? AppColors.darkBackgroundColor : Colors.white,
        systemNavigationBarColor:
            isDark ? AppColors.darkBackgroundColor : Colors.white,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: BlocProvider(
          create: (context) => SignupCubit(
            getIt.get<AuthRepo>(),
          ),
          child: const SignUpViewBody(),
        ),
      ),
    );
  }
}

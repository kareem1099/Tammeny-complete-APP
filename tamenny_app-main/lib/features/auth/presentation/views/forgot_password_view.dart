import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/features/auth/domain/repos/auth_repo.dart';
import 'package:tamenny_app/features/auth/presentation/manager/cubit/forgot_password_cubit.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        getIt<AuthRepo>(),
      ),
      child: const SafeArea(
        child: Scaffold(
          body: ForgotPasswordViewBody(),
        ),
      ),
    );
  }
}

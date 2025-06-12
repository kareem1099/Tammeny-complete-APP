import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/firebase_auth_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/profiel/domain/repo/change_password_repo.dart';
import 'package:tamenny_app/features/profiel/presentation/manager/cubit/change_password_cubit.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_change_password_bloc_consumer.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ProfileChangePasswordView extends StatelessWidget {
  const ProfileChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        getIt<ChangePasswordRepo>(),
        getIt<FirebaseAuthService>(),
      ),
      child: Scaffold(
        appBar: customAppBar(
          context,
          title: S.of(context).changePassword,
        ),
        body: const ProfileChangePasswordBlocConsumer(),
      ),
    );
  }
}

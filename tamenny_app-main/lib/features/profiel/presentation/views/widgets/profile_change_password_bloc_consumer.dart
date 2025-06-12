import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/widgets/custom_error_widget.dart';
import 'package:tamenny_app/features/profiel/presentation/manager/cubit/change_password_cubit.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_change_password_view_body.dart';

class ProfileChangePasswordBlocConsumer extends StatelessWidget {
  const ProfileChangePasswordBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ChangePasswordLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChangePasswordFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const ProfileChangePasswordViewBody();
        }
      },
    );
  }
}

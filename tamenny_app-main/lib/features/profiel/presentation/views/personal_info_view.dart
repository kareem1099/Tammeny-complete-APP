import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/storage_service.dart';

import 'package:tamenny_app/core/widgets/custom_app_bar.dart';

import 'package:tamenny_app/features/profiel/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/profile_info_view_body.dart';
import 'package:tamenny_app/generated/l10n.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: S.of(context).profileData),
      body: BlocProvider(
        create: (context) => EditProfileCubit(
          getIt.get<StorageService>(),
          getIt.get<DatabaseService>(),
        ),
        child: const ProfileInfoViewBody(),
      ),
    );
  }
}

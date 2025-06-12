import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/recommendation_sys/recomm_model.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/firestore_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';

import 'package:tamenny_app/features/community/presentation/manager/community_cubit/community_cubit.dart';
import 'package:tamenny_app/features/community/presentation/views/functions/build_add_post_floating_action_button.dart';

import 'package:tamenny_app/features/community/presentation/views/widgets/community_view_body_bloc_builder.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return BlocProvider(
      create: (context) => CommunityCubit(getIt<RecommendationRepo>(),getIt<DiseasePriorityModel>(),getIt<DatabaseService>())..fetchPostsBasedonPrefrences(),
      child: Scaffold(
        appBar: customAppBar(context, title: 'Circle', leadingIcon: false),
        floatingActionButton: buildAddPostFloatingActionButton(context),
        floatingActionButtonLocation: isArabic
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
        body: const CommunityViewBodyBlocBuilder(),
      ),
    );
  }
}

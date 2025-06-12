import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'package:tamenny_app/features/community/presentation/manager/add_comment_cubit/add_comment_cubit.dart';
import 'package:tamenny_app/features/community/presentation/views/functions/build_add_comment_floating_action_button.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/add_comment_view_body.dart';

class AddCommentView extends StatelessWidget {
  const AddCommentView({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCommentCubit(
        getIt<RecommendationRepo>(),
        getIt<DatabaseService>(),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: customAppBar(context, title: ''),
          floatingActionButton:
              buildAddCommentFloatingActionButton(context, post: post),
          body: AddCommentViewBody(post: post),
        );
      }),
    );
  }
}

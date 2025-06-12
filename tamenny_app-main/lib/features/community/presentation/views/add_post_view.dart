import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/storage_service.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'package:tamenny_app/features/community/presentation/manager/post_cubit/post_cubit.dart';
import 'package:tamenny_app/features/community/presentation/views/functions/add_post_add_bar.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/add_post_view_body.dart';

import '../../../../core/services/post_tag_prediction_service.dart'; // استيراد الكيوبت

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostCubit(
        getIt<PredictionService>(),
        getIt<RecommendationRepo>() ,
        getIt<StorageService>() ,
      ),
      child: Scaffold(
        appBar: addPostAppBar(context),
        body: const AddPostViewBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/widgets/custom_error_widget.dart';
import 'package:tamenny_app/features/community/presentation/manager/community_cubit/community_cubit.dart';
import 'package:tamenny_app/features/community/presentation/manager/community_cubit/community_state.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/community_view_body.dart';

class CommunityViewBodyBlocBuilder extends StatelessWidget {
  const CommunityViewBodyBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        if (state is CommunitySuccess) {
          return CommunityViewBody(posts: state.posts);
        } else if (state is CommunityFailure) {
          return CustomErrorWidget(
            errMessage: 'Error: ${state.message}',
          );
        } else {
          return Skeletonizer(
            enabled: true,
            child: Text(""),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/post.dart';

import '../../manager/community_cubit/community_cubit.dart';
import '../../manager/community_cubit/community_state.dart';

class CommunityViewBody extends StatefulWidget {
  const CommunityViewBody({
    super.key,
    required this.posts,
  });

  final List<PostEntity> posts;

  @override
  State<CommunityViewBody> createState() => _CommunityViewBodyState();
}

class _CommunityViewBodyState extends State<CommunityViewBody> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore) {
        isLoadingMore = true;
        context.read<CommunityCubit>().fetchPostsBasedonPrefrences(isLoadMore: true).then((_) {
          isLoadingMore = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        if (state is! CommunitySuccess) {
          return const Center(child: CircularProgressIndicator());
        }

        final posts = state.posts;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index < posts.length) {
                return Post(post: posts[index]);
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      },
    );
  }

}


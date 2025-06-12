import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';

import 'package:tamenny_app/features/community/presentation/views/widgets/post_details_view_body.dart';

class PostDetailsView extends StatelessWidget {
  final PostEntity post;

  const PostDetailsView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: ''),
      body: PostDetailsViewBody(
        post: post,
      ),
    );
  }
}

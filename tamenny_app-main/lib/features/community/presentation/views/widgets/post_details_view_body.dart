import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/comment_widget.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/no_comment_widget.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/post.dart';
import 'package:tamenny_app/generated/l10n.dart';

class PostDetailsViewBody extends StatelessWidget {
  const PostDetailsViewBody({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    final comments = post.comments ?? [];
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Post(post: post),
        const SizedBox(height: 24),
        Text(
          S.of(context).commentsTitle,
          style: AppStyles.font20Bold,
        ),
        const SizedBox(height: 12),
        comments.isEmpty
            ? const NoComments()
            : Column(
                children: List.generate(
                  comments.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child:
                    CommentWidget(
                      comment: CommentEntity(
                        username: post.comments![index].username,
                        comment: post.comments![index].comment,
                        avatarUrl: post.comments![index].avatarUrl,
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}

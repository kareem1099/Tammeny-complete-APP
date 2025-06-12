import 'package:flutter/material.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/presentation/views/add_comment_view.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/post_action.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.commentsCount,
    required this.likesCount,
    required this.sharesCount,
    this.isLiked = false,
    this.onLikePressed,
    required this.post,
  });

  final int commentsCount;
  final int likesCount;
  final int sharesCount;
  final bool isLiked;
  final VoidCallback? onLikePressed;
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PostAction(
            counts: likesCount,
            iconPath: Assets.imagesLoveIcon,
            isLiked: isLiked, // 👈 مرر القيمة هنا
            onTap: onLikePressed,
          ),
        ),
        Expanded(
          child: PostAction(
            counts: commentsCount,
            iconPath: Assets.imagesCommentIcon,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddCommentView(post: post),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: PostAction(
            counts: sharesCount,
            iconPath: Assets.imagesShareIcon,
          ),
        ),
      ],
    );
  }
}

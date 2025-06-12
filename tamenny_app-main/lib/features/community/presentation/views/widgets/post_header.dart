import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/presentation/views/functions/get_time_age.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(post.userAvatarUrl),
            ),
            const SizedBox(width: 4),
            Text(
              post.username,
              style: AppStyles.font13Bold,
            ),
            const SizedBox(width: 5),
            Text(
              getTimeAgo(post.createdAt),
              style: AppStyles.font13Bold,
            ),
          ],
        ),
        SvgPicture.asset(Assets.imagesMoreOptionIcon)
      ],
    );
  }
}

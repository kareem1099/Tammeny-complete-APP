import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';

class CommentWidget extends StatelessWidget {
  final CommentEntity comment;

  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    String currentUserId = context.read<UserCubit>().currentUser!.uId;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffEEEEEE),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => PostDetailsView(post: post),
                //   ),
                // );
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(comment.avatarUrl!),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              comment.username,
                              style: AppStyles.font13Bold,
                            ),
                            const SizedBox(width: 5),
                            // Text(
                            //   getTimeAgo(comment.createdAt),
                            //   style: AppStyles.font13Bold,
                            // ),
                          ],
                        ),
                        SvgPicture.asset(Assets.imagesMoreOptionIcon)
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      comment.comment,
                      style: AppStyles.font13Regular
                          .copyWith(color: const Color(0xff676767)),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 18),
                    // if (comment.imageUrl!.isNotEmpty)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 12.0),
                    //     child: SizedBox(
                    //       width: MediaQuery.of(context).size.width,
                    //       child: AspectRatio(
                    //         aspectRatio: 3 / 2,
                    //         child: Image.network(
                    //           post.imageUrl!,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
            // PostActions(
            //   commentsCount: post.commentsCount,
            //   likesCount: post.likedBy.length,
            //   sharesCount: post.sharesCount,
            //   isLiked: post.likedBy.contains(currentUserId),
            //   onLikePressed: () async {
            //     // إضافة الـ Like أو إزالته
            //     await context
            //         .read<CommunityCubit>()
            //         .likePost(post: post, userId: currentUserId);

            //     // بعد إضافة الـ Like في الـ Backend، نقوم بتحديث الـ UI مباشرة
            //     context.read<CommunityCubit>().toggleLikeInPost(
            //           postId: post.postId,
            //           userId: currentUserId,
            //         );
            //   },
            //   post: post,
            // ),
          ],
        ),
      ),
    );
  }
}

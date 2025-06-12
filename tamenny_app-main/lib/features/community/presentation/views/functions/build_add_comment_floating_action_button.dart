import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/presentation/manager/add_comment_cubit/add_comment_cubit.dart';

FloatingActionButton buildAddCommentFloatingActionButton(BuildContext context,
    {required PostEntity post}) {
  return FloatingActionButton(
    heroTag: UniqueKey(),
    onPressed: () {
      context.read<AddCommentCubit>().addComment(post: post);
    },
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    child: const Icon(Icons.send),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/presentation/manager/add_comment_cubit/add_comment_cubit.dart';
import 'package:tamenny_app/generated/l10n.dart';

class AddCommentViewBody extends StatefulWidget {
  const AddCommentViewBody({super.key, required this.post});
  final PostEntity post;

  @override
  State<AddCommentViewBody> createState() => _AddCommentViewBodyState();
}

class _AddCommentViewBodyState extends State<AddCommentViewBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);

    return BlocConsumer<AddCommentCubit, AddCommentState>(
      listener: (context, state) {
        if (state is AddCommentSuccess) {
          showErrorBar(context, message: locale.commentAdded);
          Navigator.pop(context);
        } else if (state is AddCommentFailure) {
          showErrorBar(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddCommentLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,

                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.deepGrayColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              widget.post.postText,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (widget.post.imageUrl != null &&
                              widget.post.imageUrl!.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: widget.post.imageUrl!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Skeletonizer(
                                  enabled: true,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        getIt<UserCubit>().currentUser!.userAvatarUrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          context.read<AddCommentCubit>().commentText = value;
                        },
                        maxLines: null,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: locale.postYourReply,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        context.watch<UserCubit>().currentUser?.userAvatarUrl ?? '';

    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              placeholder: (context, url) => Skeletonizer(
                enabled: true,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                size: 32,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.read<UserCubit>().currentUser!.name,
                style: AppStyles.font18SemiBold),
            const SizedBox(height: 4),
            Text(context.read<UserCubit>().currentUser!.email,
                style:
                    AppStyles.font12Regular.copyWith(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }
}

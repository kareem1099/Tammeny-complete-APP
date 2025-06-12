import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/notification_icon_widget.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_styles.dart';

class HomeCustomAppBar extends StatelessWidget {
  const HomeCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        context.watch<UserCubit>().currentUser?.userAvatarUrl ?? '';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: avatarUrl,
            fit: BoxFit.cover,
            width: 40,
            height: 40,
            placeholder: (context, url) => Skeletonizer(
              enabled: true,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.person, size: 20),
          ),
        ),
      ),
      title: Text(
        '${S.of(context).hi} ${getIt<UserCubit>().currentUser!.name}',
        style: AppStyles.font18Bold.copyWith(),
      ),
      subtitle: Text(
        S.of(context).howAreYouToday,
        style: AppStyles.font11Regular.copyWith(
          color: const Color(0xff616161),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(Routes.notificationView);
        },
        child: const NotificationIconWidget(),
      ),
    );
  }
}

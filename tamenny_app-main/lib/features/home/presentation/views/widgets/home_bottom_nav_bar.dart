import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/home/presentation/views/home_view.dart';
import 'package:tamenny_app/features/map/presentation/views/nearby_doctors_view.dart';
import 'package:tamenny_app/features/profiel/presentation/views/profile_view.dart';

import '../../../../chatbot/presentation/views/chat_bot_welcome_view.dart';
import '../../../../community/presentation/views/community_view.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

// style 5 , 6
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      backgroundColor: theme.scaffoldBackgroundColor,
      navBarStyle: NavBarStyle.style6,
      decoration: const NavBarDecoration(),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const CommunityView(),
      const ChatbotWelcomeView(),
      const NearbyDoctorsView(),
      const ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    final avatarUrl =
        context.watch<UserCubit>().currentUser?.userAvatarUrl ?? '';

    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.imagesHomeActiveIcon),
        inactiveIcon: SvgPicture.asset(Assets.imagesHomeInactiveIcon),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.imagesGroupFillIcon,
          width: 35,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.imagesGroupLightIcon,
          width: 35,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.imagesChatbotFill,
          width: 35,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.imagesChatbotLightIcon,
          width: 30,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.imagesMapFillIcon,
          width: 35,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.imagesMapLightIcon,
          width: 35,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Opacity(
          opacity: 0.6,
          child: _buildProfileAvatar(avatarUrl),
        ),
        inactiveIcon: _buildProfileAvatar(avatarUrl),
      ),
    ];
  }
}

Widget _buildProfileAvatar(String avatarUrl) {
  return CircleAvatar(
    radius: 12,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        fit: BoxFit.cover,
        width: 24,
        height: 24,
        placeholder: (context, url) => Skeletonizer(
          enabled: true,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error, size: 16),
      ),
    ),
  );
}

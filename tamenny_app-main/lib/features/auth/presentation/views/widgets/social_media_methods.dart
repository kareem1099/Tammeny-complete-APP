import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:tamenny_app/features/auth/presentation/views/widgets/social_media_item.dart';

import '../../../../../core/utils/app_assets.dart';

class SocialMediaMethods extends StatelessWidget {
  const SocialMediaMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaItem(
          onTap: () {
            context.read<SigninCubit>().signInWithGoogle();
          },
          socialMediaImageSource: Assets.imagesGoogleIcon,
        ),
        const SizedBox(
          width: 24,
        ),
        SocialMediaItem(
          onTap: () {
            context.read<SigninCubit>().signInWithFacebook();
          },
          socialMediaImageSource: Assets.imagesFacebookIcon,
        ),
      ],
    );
  }
}

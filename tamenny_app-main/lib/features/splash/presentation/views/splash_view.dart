import 'package:flutter/material.dart';
import 'package:tamenny_app/config/cache_helper.dart';
import 'package:tamenny_app/constants.dart';
import 'package:tamenny_app/core/functions/custom_navigation_from_splash_to_another_views.dart';
import 'package:tamenny_app/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool? isOnboardingVisited =
          CacheHelper.getBool(key: kIsOnBoardingVisited) ?? false;

       customNavigationFromSplashToAnotherViews(context, isOnboardingVisited);
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}

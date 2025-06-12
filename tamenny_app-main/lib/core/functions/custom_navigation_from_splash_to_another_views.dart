import 'package:flutter/material.dart';
import 'package:tamenny_app/config/cache_helper.dart';
import 'package:tamenny_app/constants.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/services/firebase_auth_service.dart';

Future<Null> customNavigationFromSplashToAnotherViews (
    BuildContext context, bool? isOnboardingVisited) {
  return Future.delayed(
    const Duration(milliseconds: 1000),
    () {
      if (isOnboardingVisited == true) {
        FirebaseAuthService().isLoggedIn()
            ? Navigator.pushReplacementNamed(context, Routes.bottomNavBarView)
            : Navigator.pushReplacementNamed(context, Routes.loginView);
      } else {
        CacheHelper.set(key: kIsOnBoardingVisited, value: true);
        Navigator.pushReplacementNamed(context, Routes.welcomeView);
      }
    },
  );
}

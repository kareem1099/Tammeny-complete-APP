import 'package:flutter/material.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/widgets/on_boarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: OnBoardingViewBody(),
      ),
    );
  }
}

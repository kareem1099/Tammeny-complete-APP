import 'package:flutter/material.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/widgets/on_boarding_custom_button.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.controller,
    required this.currentPage,
  });
  final PageController controller;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOnboardingButton(
            controller: controller,
            currentPage: currentPage,
          ),
          const SizedBox(
            height: 46,
          ),
        ],
      ),
    );
  }
}

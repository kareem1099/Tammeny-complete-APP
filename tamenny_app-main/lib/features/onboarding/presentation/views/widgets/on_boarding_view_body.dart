import 'package:flutter/material.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/onboarding/domain/entites/on_boarding_entity.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/widgets/on_boarding_button_section.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/widgets/on_boarding_page_view_body.dart';
import 'package:tamenny_app/generated/l10n.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController controller = PageController();

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<OnBoardingEntity> onBoardingEntites = [
      OnBoardingEntity(
        numberOfStep: S.of(context).stepOne,
        image: Assets.imagesOnboarding2,
        textDesc: S.of(context).aiResults,
      ),
      OnBoardingEntity(
        numberOfStep: S.of(context).stepTwo,
        image: Assets.imagesOnboarding3,
        textDesc: S.of(context).healthInsights,
      ),
      OnBoardingEntity(
        numberOfStep: S.of(context).stepThree,
        image: Assets.imagesOnboarding4,
        textDesc: S.of(context).connectGrow,
      ),
    ];
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          onPageChanged: (index) {
            setState(
              () {
                currentPageIndex = index;
              },
            );
          },
          itemBuilder: (context, index) {
            return OnBoardingPageViewBody(
              controller: controller,
              onBoardingEntity: onBoardingEntites[index],
            );
          },
          itemCount: onBoardingEntites.length,
        ),
        BottomSection(
          controller: controller,
          currentPage: currentPageIndex,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class MainBannerWidget extends StatelessWidget {
  const MainBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 165,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: AssetImage(
                  Assets.imagesMainBannerBackground,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).aiPoweredHealthInsights,
                  style: AppStyles.font17Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).startNewScan,
                        style: AppStyles.font10Regular.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: Directionality.of(context) == TextDirection.ltr ? 15 : null,
            left: Directionality.of(context) == TextDirection.rtl ? 15 : null,
            top: 0,
            child: Image.asset(
              Assets.imagesFemaleDoctorImage,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}

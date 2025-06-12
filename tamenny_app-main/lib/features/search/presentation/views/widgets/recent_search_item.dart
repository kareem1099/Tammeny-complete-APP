import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.imagesTimeIcon),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dental',
                style: AppStyles.font14Regular.copyWith(
                  color: const Color(0xff9E9E9E),
                ),
              ),
              SvgPicture.asset(Assets.imagesCloseIcon),
            ],
          ),
        ),
      ],
    );
  }
}

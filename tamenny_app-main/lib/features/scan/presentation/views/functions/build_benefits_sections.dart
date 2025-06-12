import 'package:flutter/material.dart';
import 'package:tamenny_app/features/scan/presentation/views/functions/build_benefit_item.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/theme/app_styles.dart';

Widget buildBenefitsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        S.of(context).why_choose_tamenny_title,
        style: AppStyles.font20SemiBold,
      ),
      const SizedBox(height: 16),
      buildBenefitItem(
        icon: Icons.shield_outlined,
        text: S.of(context).why_choose_tamenny_reason_1,
      ),
      const SizedBox(height: 10),
      buildBenefitItem(
        icon: Icons.timer_outlined,
        text: S.of(context).why_choose_tamenny_reason_2,
      ),
      const SizedBox(height: 10),
      buildBenefitItem(
        icon: Icons.directions_walk_outlined,
        text: S.of(context).why_choose_tamenny_reason_3,
      ),
    ],
  );
}

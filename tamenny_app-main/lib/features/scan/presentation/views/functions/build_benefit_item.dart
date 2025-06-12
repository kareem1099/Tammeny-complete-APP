import 'package:flutter/material.dart';

import '../../../../../core/theme/app_styles.dart';

Widget buildBenefitItem({required IconData icon, required String text}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: Colors.green),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          text,
          style: AppStyles.font16Regular.copyWith(color: Colors.black87),
        ),
      ),
    ],
  );
}

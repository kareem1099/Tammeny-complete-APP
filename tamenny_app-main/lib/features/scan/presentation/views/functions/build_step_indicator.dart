import 'package:flutter/material.dart';

import '../../../../../core/theme/app_styles.dart';

Widget buildStepIndicator({
  required String step,
  required String title,
  required String description,
  required IconData icon,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blue.shade100,
        child: Text(
          step,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: AppStyles.font20SemiBold,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: AppStyles.font16Regular.copyWith(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';

class LatestScanResultView extends StatelessWidget {
  final String status;
  final String resultDescription;
  final List<String> adviceList;

  const LatestScanResultView({
    super.key,
    required this.status,
    required this.resultDescription,
    required this.adviceList,
  });

  Color getStatusColor(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'critical':
        return Colors.redAccent;
      case 'moderate':
        return Colors.amber;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'normal':
        return Icons.check_circle_outline;
      case 'critical':
        return Icons.error_outline;
      case 'moderate':
        return Icons.warning_amber_rounded;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackgroundColor : AppColors.grayColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Scan Result',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor:
            isDark ? AppColors.darkTextColor : AppColors.blueDarkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Diagnosis Status Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.darkCardColor : AppColors.deepGrayColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    getStatusIcon(),
                    color: getStatusColor(context),
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Result: $status',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(context),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          resultDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark
                                ? AppColors.darkSecondaryTextColor
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Advice Title
            Text(
              "Preventive Tips",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.darkTextColor : AppColors.blueDarkColor,
              ),
            ),
            const SizedBox(height: 12),

            // Advice List
            ...adviceList.map(
              (advice) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check,
                        color: AppColors.primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        advice,
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              isDark ? AppColors.darkTextColor : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Share logic
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('مشاركة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: const BorderSide(color: AppColors.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('تم'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

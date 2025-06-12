import 'package:flutter/material.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/features/scan/domain/entites/scan_details_entity.dart';
import 'package:tamenny_app/features/scan/presentation/views/functions/build_benefits_sections.dart';
import 'package:tamenny_app/features/scan/presentation/views/functions/build_step_indicator.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ScanViewBody extends StatelessWidget {
   const ScanViewBody({super.key, required this.scan});
  final ScanDetailsEntity scan;

  @override
  Widget build(BuildContext context) {
    final String title = scan.analysisTitle;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesDoctorWelcomeModel, height: 200),
            const SizedBox(height: 10),
            Text(
              S.of(context).upload_scan_description,
              style: AppStyles.font16Regular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 30),
        buildStepIndicator(
          step: '1',
          title: S.of(context).upload_scan_title,
          description: S.of(context).upload_scan_instruction,
          icon: Icons.upload_file_rounded,
        ),
        const Divider(height: 40),
        buildStepIndicator(
          step: '2',
          title: title,
          description: S.of(context).ai_analysis_description,
          icon: Icons.analytics_outlined,
        ),
        const Divider(height: 40),
        buildStepIndicator(
          step: '3',
          title: S.of(context).get_results_title,
          description: scan.analysisGuidanceMessages,
          icon: Icons.check_circle_outline,
        ),
        const SizedBox(height: 40),
        buildBenefitsSection(context),
        const SizedBox(height: 40),
        CustomAppButton(
          text: S.of(context).proceed_to_upload,
          onTap: () {
            Navigator.pushNamed(context, Routes.uploadFileView,arguments:title);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';

class CompletedViewBody extends StatelessWidget {
  const CompletedViewBody({super.key, required this.diagnosisResultEntity});
  final DiagnosisResultEntity diagnosisResultEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Image.asset(Assets.imagesDoctorCompletedModel),
          const SizedBox(
            height: 57,
          ),
          Text(
            'Completed',
            textAlign: TextAlign.center,
            style: AppStyles.font48SemiBold.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Good health starts with awareness. Thanks for letting Tamenny help you take that step!',
              textAlign: TextAlign.center,
              style: AppStyles.font16Medium.copyWith(color: Colors.white60),
            ),
          ),
          const SizedBox(
            height: 108,
          ),
          CustomAppButton(
            text: 'Show Results',
            bgColor: const Color(0xffD3A9FF).withOpacity(0.25),
            onTap: () {
              Navigator.pushNamed(context, Routes.scanAnalysisResultsScreen,
                  arguments: diagnosisResultEntity);
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

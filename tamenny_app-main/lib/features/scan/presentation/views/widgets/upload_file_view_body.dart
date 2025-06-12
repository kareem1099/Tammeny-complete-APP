import 'package:flutter/material.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/generated/l10n.dart';

class UploadFileViewBody extends StatelessWidget {
  const UploadFileViewBody({super.key,required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Image.asset(Assets.imagesDoctorUploadFile),
          Text(
            S.of(context).upload_prompt_button,
            textAlign: TextAlign.center,
            style: AppStyles.font48SemiBold
                .copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            S.of(context).upload_prompt_description,
            textAlign: TextAlign.center,
            style: AppStyles.font16SemiBold
                .copyWith(color: const Color(0xff242424)),
          ),
          const SizedBox(
            height: 60,
          ),
          CustomAppButton(
            text: S.of(context).upload_prompt_button,
            onTap: () {
              Navigator.pushNamed(context, Routes.previewScanView,arguments:title);
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

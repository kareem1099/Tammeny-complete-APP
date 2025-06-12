import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/features/scan/presentation/views/widgets/completed_view_body.dart';

class CompletedView extends StatelessWidget {
  const CompletedView({super.key, required this.diagnosisResultEntity});
  final DiagnosisResultEntity diagnosisResultEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff094E6C),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: CompletedViewBody(
          diagnosisResultEntity: diagnosisResultEntity,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/scan/domain/repos/diagnosis_repo.dart';
import 'package:tamenny_app/features/scan/presentation/manager/cubit/dianosis_cubit.dart';
import 'package:tamenny_app/features/scan/presentation/views/widgets/preview_scan_view_body.dart';

class PreviewScanView extends StatelessWidget {
  const PreviewScanView({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiagnosisCubit(getIt<DiagnosisRepo>()),
      child: Scaffold(
        appBar: customAppBar(context, title: 'Preview Your Scan'),
        body:  PreviewScanViewBody(title:title),
      ),
    );
  }
}

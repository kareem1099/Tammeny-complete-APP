import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/features/scan/presentation/manager/cubit/dianosis_state.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/helper/notification_helper.dart';
import '../../manager/cubit/dianosis_cubit.dart';

class PreviewScanViewBody extends StatefulWidget {
  const PreviewScanViewBody({super.key,required this.title});
  final String title;

  @override
  State<PreviewScanViewBody> createState() => _PreviewScanViewBodyState();
}

class _PreviewScanViewBodyState extends State<PreviewScanViewBody> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;
  bool _isLoading = false;

  Future<void> _pickImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    final image = await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = image != null ? XFile(image.path) : null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiagnosisCubit, DiagnosisState>(
      listener: (context, state) async {
        if (state is DiagnosisSuccess) {
          Navigator.pushNamed(context, Routes.completedScreen,
              arguments: state.diagnosisResultEntity);
          NotificationService.instance.showCustomNotification(
            title: 'Diagnosis complete',
            body: 'Check your results',
          );

        } else if (state is DiagnosisFailure) {
          log(state.errMessage);
          showErrorBar(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is DiagnosisLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                    'https://lottie.host/c14b4722-a922-4bbb-9cda-1c836fa19d4a/Mr5j84wclT.json'),
                const Text('Loading .... '),
              ],
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Expanded(child: SizedBox(height: 16)),
                  InkWell(
                    onTap: _pickImageFromGallery,
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[100],
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : _pickedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(_pickedImage!.path),
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 40,
                                      color: Colors.blueAccent,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      S.of(context).upload_scan_prompt,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                  const Expanded(child: SizedBox(height: 24)),
                  CustomAppButton(
                    text: S.of(context).status_processed,
                    onTap: () {
                      if (_pickedImage != null) {

                        Future<void> incrementScanCount(String tag) async {
                          final prefs = await SharedPreferences.getInstance();
                          final key = 'scan_${tag}';
                          final currentCount = prefs.getInt(key) ?? 0;
                          await prefs.setInt(key, currentCount + 1);
                        }
                        String tag = widget.title;
                        if (widget.title=="تحليل أمراض القلب"){
                          tag = "Heart Disease Analysis";
                        }
                        if (widget.title=="سرطان الدماغ"){
                          tag = "Brain Cancer";
                        }
                        if (widget.title=="سرطان الرئة"){
                          tag = "Lung Cancer";
                        }if(widget.title=="التهاب مفصل الركبة (الفُصال العظمي)"){
                          tag="Knee Osteoarthritis (OA)";
                        }
                        context
                            .read<DiagnosisCubit>()
                            .startDiagnosis(image: _pickedImage!,tag: tag);
                        incrementScanCount(tag.split(" ").first.toLowerCase());

                      } else {
                        showErrorBar(context,
                            message: S.of(context).select_image_prompt);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

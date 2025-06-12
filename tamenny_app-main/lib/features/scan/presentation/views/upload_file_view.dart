import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/scan/presentation/views/widgets/upload_file_view_body.dart';

class UploadFileView extends StatelessWidget {
  const UploadFileView({super.key,required this.title});
 final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Scan'),
      body: UploadFileViewBody(title: title)
    );
  }
}

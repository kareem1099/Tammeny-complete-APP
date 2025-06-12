import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/map/presentation/views/widgets/doctor_details_view_body.dart';

class DoctorDetailsView extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorDetailsView({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: doctor.name),
      body: DoctorDetailsViewBody(
        doctor: doctor,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/doctor_card.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/nearby_doctors_list_view_body.dart';
import 'package:tamenny_app/generated/l10n.dart';

class NearbyDoctorsListView extends StatelessWidget {
  const NearbyDoctorsListView({super.key, required this.doctors});
  final List<DoctorEntity> doctors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: S.of(context).doctors),
      body: NearbyDoctorsListViewBody(doctors: doctors),
    );
  }
}

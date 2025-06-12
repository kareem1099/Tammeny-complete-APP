import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/doctor_card.dart';

class NearbyDoctorsSliverList extends StatelessWidget {
  const NearbyDoctorsSliverList({super.key, required this.doctors});
  final List<DoctorEntity> doctors;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 3,
      itemBuilder: (context, index) => DoctorCard(
        doctor: doctors[index],
      ),
    );
  }
}

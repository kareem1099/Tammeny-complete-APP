import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/doctor_card.dart';

class NearbyDoctorsListViewBody extends StatelessWidget {
  const NearbyDoctorsListViewBody({super.key, required this.doctors});

  final List<DoctorEntity> doctors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: doctors.length,
        itemBuilder: (context, index) => DoctorCard(
          doctor: doctors[index],
        ),
      ),
    );
  }
}

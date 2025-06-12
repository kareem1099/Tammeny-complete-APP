import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/features/map/presentation/views/functions/call_doctor.dart';
import 'package:tamenny_app/features/map/presentation/views/widgets/doctor_details_image.dart';
import 'package:tamenny_app/generated/l10n.dart';

class DoctorDetailsViewBody extends StatelessWidget {
  const DoctorDetailsViewBody({super.key, required this.doctor});
  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
      child: Column(
        children: [
          if (doctor.imageUrl != null) DoctorDetailsImage(doctor: doctor),
          const SizedBox(height: 16),
          Text(
            doctor.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (doctor.specialty != null)
            Text(
              doctor.specialty!,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          const SizedBox(height: 12),
          if (doctor.rating != null)
            Row(
              children: [
                SvgPicture.asset(Assets.imagesStarFillIcon),
                const SizedBox(width: 4),
                Text(doctor.rating.toString()),
              ],
            ),
          const SizedBox(height: 12),
          if (doctor.address != null)
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(doctor.address!)),
              ],
            ),
          const Spacer(),
          if (doctor.phone != null)
            CustomAppButton(
              text: S.of(context).callDoctor,
              onTap: () {
                callDoctor(doctor.phone!);
              },
            ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';

class DoctorDetailsImage extends StatelessWidget {
  const DoctorDetailsImage({
    super.key,
    required this.doctor,
  });

  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 3 / 2.5,
        child: CachedNetworkImage(
          imageUrl: doctor.imageUrl!,
          fit: BoxFit.fill,
          placeholder: (context, url) => Skeletonizer(
            enabled: true,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[100],
            child: Image.asset(Assets.imagesNoPhotoIcon),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/features/map/presentation/views/doctor_details_view.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailsView(doctor: doctor),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.grey.shade800
                : AppColors.deepGrayColor.withOpacity(0.6),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 65,
                height: 65,
                child: CachedNetworkImage(
                  imageUrl: doctor.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color:
                        isDark ? Colors.grey.shade700 : AppColors.deepGrayColor,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark
                          ? theme.textTheme.bodyLarge?.color
                          : AppColors.blueDarkColor,
                    ),
                  ),
                  if (doctor.specialty != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        doctor.specialty!,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.darkPrimaryColor
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: isDark
                                ? AppColors.darkPrimaryColor
                                : AppColors.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 180),
                            child: Text(
                              doctor.address ?? doctor.city,
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (doctor.rating != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber.shade600,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                doctor.rating!.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? Colors.grey.shade500
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/features/map/presentation/views/doctor_details_view.dart';

Marker buildCustomMarker({required DoctorEntity doctor}) {
  return Marker(
    point: LatLng(doctor.latitude, doctor.longitude),
    width: 100,
    height: 110,
    builder: (BuildContext context) => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DoctorDetailsView(doctor: doctor),
          ),
        );
      },
      child: Column(
        children: [
          // Doctor Photo
          ClipOval(
            child: Image.network(
              doctor.imageUrl ??
                  '', // Make sure doctor.imageUrl is a valid image URL
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, size: 50),
            ),
          ),
          const SizedBox(height: 4),
          // Doctor Name
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              doctor.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Location Pin Icon
          const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 28,
          ),
        ],
      ),
    ),
  );
}

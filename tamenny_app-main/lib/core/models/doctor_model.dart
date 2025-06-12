import 'package:tamenny_app/core/entites/doctor_entity.dart';

class DoctorModel {
  final String name;
  final double latitude;
  final double longitude;
  final String? specialty;
  final String city;
  final String? imageUrl;
  final double? rating;
  final String? address;
  final String? phone;

  DoctorModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.specialty,
    required this.city,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.phone,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      specialty: json['specialty'],
      city: json['city'],
      imageUrl: json['imageUrl'],
      rating:
          json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      address: json['address'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'specialty': specialty,
      'city': city,
      'imageUrl': imageUrl,
      'rating': rating,
      'address': address,
      'phone': phone,
    };
  }

  factory DoctorModel.fromEntity(DoctorEntity doctor) {
    return DoctorModel(
      name: doctor.name,
      latitude: doctor.latitude,
      longitude: doctor.longitude,
      specialty: doctor.specialty,
      city: doctor.city,
      imageUrl: doctor.imageUrl,
      rating: doctor.rating,
      address: doctor.address,
      phone: doctor.phone,
    );
  }

  DoctorEntity toEntity() {
    return DoctorEntity(
      name: name,
      latitude: latitude,
      longitude: longitude,
      specialty: specialty,
      city: city,
      imageUrl: imageUrl,
      rating: rating,
      address: address,
      phone: phone,
    );
  }
}

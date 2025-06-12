class DoctorEntity {
  final String name;
  final double latitude;
  final double longitude;
  final String? specialty;
  final String city;
  final String? imageUrl;
  final double? rating;
  final String? address;
  final String? phone;

  DoctorEntity({
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
}

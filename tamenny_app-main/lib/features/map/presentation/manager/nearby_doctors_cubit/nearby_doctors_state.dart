part of 'nearby_doctors_cubit.dart';

@immutable
sealed class NearbyDoctorsState {}

final class NearbyDoctorsInitial extends NearbyDoctorsState {}

final class NearbyDoctorsLoading extends NearbyDoctorsState {}

final class NearbyDoctorsSuccess extends NearbyDoctorsState {
  final List<DoctorEntity> doctors;

  NearbyDoctorsSuccess({
    required this.doctors,
  });
}

final class NearbyDoctorsFailure extends NearbyDoctorsState {
  final String errMessage;

  NearbyDoctorsFailure({
    required this.errMessage,
  });
}

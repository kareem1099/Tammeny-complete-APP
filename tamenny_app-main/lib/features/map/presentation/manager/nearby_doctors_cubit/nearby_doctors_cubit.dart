import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/features/map/domain/repos/nearby_doctors_repo.dart';

part 'nearby_doctors_state.dart';

class NearbyDoctorsCubit extends Cubit<NearbyDoctorsState> {
  NearbyDoctorsCubit(this.nearbyDoctorsRepo) : super(NearbyDoctorsInitial());
  final NearbyDoctorsRepo nearbyDoctorsRepo;
  List<DoctorEntity> doctorsList = [];

  fetchNearbyDoctors() async {
    emit(NearbyDoctorsLoading());
    var result = await nearbyDoctorsRepo.fetchNearbyDoctors();
    result.fold((f) => emit(NearbyDoctorsFailure(errMessage: f.errMessage)),
        (doctors) {
      emit(NearbyDoctorsSuccess(doctors: doctors));
      doctorsList = doctors;
    });
  }
}

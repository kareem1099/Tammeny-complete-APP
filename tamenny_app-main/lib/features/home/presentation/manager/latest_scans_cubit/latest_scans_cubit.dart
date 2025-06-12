import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/features/home/domain/repos/latest_scans_repo.dart';

part 'latest_scans_state.dart';

class LatestScansCubit extends Cubit<LatestScansState> {
  LatestScansCubit(this.latestScansRepo) : super(LatestScansInitial());

  final LatestScansRepo latestScansRepo;

  fetchLatestScans() async {
    emit(LatestScansLoading());
    var result = await latestScansRepo.fetchLatestScans(
        userId: getIt<UserCubit>().currentUser!.uId);

    result.fold((f) => emit(LatestScansFailure(errMessage: f.errMessage)),
        (diagnosis) => emit(LatestScansSuccess(diagnosis: diagnosis)));
  }
}

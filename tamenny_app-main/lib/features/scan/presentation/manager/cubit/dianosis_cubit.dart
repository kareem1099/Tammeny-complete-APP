
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/features/scan/domain/repos/diagnosis_repo.dart';
import 'package:tamenny_app/features/scan/presentation/manager/cubit/dianosis_state.dart';

class DiagnosisCubit extends Cubit<DiagnosisState> {
  DiagnosisCubit(this.diagnosisRepo) : super(DiagnosisInitial());

  final DiagnosisRepo diagnosisRepo;

  late DiagnosisResultEntity diagnosisResultEntity;

  startDiagnosis({required XFile image,required String tag}) async {
    emit(DiagnosisLoading());

    var result = await diagnosisRepo.startDiagnosis(image: image,tag: tag);
    result.fold((f) => emit(DiagnosisFailure(errMessage: f.errMessage)),
        (data) {
      diagnosisResultEntity = data;
      emit(DiagnosisSuccess(diagnosisResultEntity: data));
    });
  }
}

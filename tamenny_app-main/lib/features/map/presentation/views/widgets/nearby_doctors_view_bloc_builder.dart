import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/functions/get_dummy_doctors.dart';
import 'package:tamenny_app/core/widgets/custom_error_widget.dart';
import 'package:tamenny_app/features/map/presentation/manager/nearby_doctors_cubit/nearby_doctors_cubit.dart';
import 'package:tamenny_app/features/map/presentation/views/widgets/nearby_doctors_view_.dart';

class NearbyDoctorsViewBlocBuilder extends StatelessWidget {
  const NearbyDoctorsViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyDoctorsCubit, NearbyDoctorsState>(
      builder: (context, state) {
        if (state is NearbyDoctorsSuccess) {
          return NearbyDoctorsViewBody(doctors: state.doctors);
        } else if (state is NearbyDoctorsFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return Skeletonizer(
            enabled: true,
            child: NearbyDoctorsViewBody(
              doctors: getDummyDoctors(),
            ),
          );
        }
      },
    );
  }
}

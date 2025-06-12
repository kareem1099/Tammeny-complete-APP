import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_view_custom_header.dart';
import 'package:tamenny_app/features/map/presentation/manager/nearby_doctors_cubit/nearby_doctors_cubit.dart';
import 'package:tamenny_app/generated/l10n.dart';

class NearbyDoctorsSection extends StatelessWidget {
  const NearbyDoctorsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeViewCustomHeader(
            text: S.of(context).nearbyDoctors,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(
                  Routes.nearbyDoctorsListView,
                  arguments: context.read<NearbyDoctorsCubit>().doctorsList);
            },
            child: Text(
              S.of(context).readMore,
              style: AppStyles.font12Regular.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

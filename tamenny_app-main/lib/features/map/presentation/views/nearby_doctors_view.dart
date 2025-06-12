import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/map/presentation/views/widgets/nearby_doctors_view_bloc_builder.dart';
import 'package:tamenny_app/generated/l10n.dart';

class NearbyDoctorsView extends StatelessWidget {
  const NearbyDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: S.of(context).nearbyDoctors),
      body: const NearbyDoctorsViewBlocBuilder(),
    );
  }
}

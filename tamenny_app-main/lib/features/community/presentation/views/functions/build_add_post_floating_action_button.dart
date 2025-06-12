import 'package:flutter/material.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';

FloatingActionButton buildAddPostFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    heroTag: UniqueKey(),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pushNamed(Routes.addPostView);
    },
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    child: const Directionality(
      textDirection: TextDirection.ltr,
      child: Icon(Icons.add),
    ),
  );
}

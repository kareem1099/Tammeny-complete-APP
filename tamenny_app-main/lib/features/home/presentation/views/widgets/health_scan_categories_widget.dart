import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/home/domain/entites/health_scan_category_entity.dart';
import 'package:tamenny_app/generated/l10n.dart';

import 'health_scan_categories_header_widget.dart';
import 'health_scan_item_widget.dart';

class HealthScanCategoriesWidget extends StatefulWidget {
  const HealthScanCategoriesWidget({super.key});

  @override
  State<HealthScanCategoriesWidget> createState() =>
      _HealthScanCategoriesWidgetState();
}

class _HealthScanCategoriesWidgetState
    extends State<HealthScanCategoriesWidget> {
  List<MapEntry<String, double>> sortedScores = [];

  @override
  void initState() {
    super.initState();
    _loadSortedScores();
  }

  Future<void> _loadSortedScores() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('sorted_disease_scores');

    if (jsonList != null) {
      final List<MapEntry<String, double>> scores = jsonList
          .map((jsonStr) {
        final map = jsonDecode(jsonStr);
        return MapEntry<String, double>(
            map['key'], map['value'].toDouble());
      })
          .where((entry) => entry.key != 'neutral')
          .toList();

      setState(() {
        sortedScores = scores;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allCategories = {
      'heart': HealthScanCategoryEntity(
        title: S.of(context).heart,
        image: Assets.imagesHeartIcon,
      ),
      'lung': HealthScanCategoryEntity(
        title: S.of(context).lungCancer,
        image: Assets.imagesLungsIcon,
      ),
      'brain': HealthScanCategoryEntity(
        title: S.of(context).brainCancer,
        image: Assets.imagesBrainIcon,
      ),
      'knee': HealthScanCategoryEntity(
        title: S.of(context).kneeOa,
        image: Assets.imagesBoneIcon,
      ),
    };

    final List<HealthScanCategoryEntity> displayCategories = sortedScores
        .where((entry) => allCategories.containsKey(entry.key))
        .map((entry) => allCategories[entry.key]!)
        .toList();

    final categoriesToShow = displayCategories.isNotEmpty
        ? displayCategories
        : [
      allCategories['heart']!,
      allCategories['lung']!,
      allCategories['brain']!,
      allCategories['knee']!,
    ];

    return Column(
      children: [
        const HealthScanCategoriesHeaderWidget(),
        const SizedBox(height: 16),
        Row(
          children: List.generate(
            categoriesToShow.length,
                (index) => Expanded(
              child: HealthScanItemWidget(
                healthScanCategoryEntity: categoriesToShow[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

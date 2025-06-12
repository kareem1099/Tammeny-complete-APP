import 'package:flutter/material.dart';
import 'package:tamenny_app/features/search/presentation/views/widgets/recent_search_header.dart';
import 'package:tamenny_app/features/search/presentation/views/widgets/recent_search_item.dart';

class RecentSearchSection extends StatelessWidget {
  const RecentSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RecentSearchHeader(),
        SizedBox(
          height: 16.0,
        ),
        RecentSearchItem(),
        SizedBox(
          height: 12.0,
        ),
        RecentSearchItem(),
        SizedBox(
          height: 12.0,
        ),
        RecentSearchItem(),
        SizedBox(
          height: 12.0,
        ),
        RecentSearchItem(),
      ],
    );
  }
}

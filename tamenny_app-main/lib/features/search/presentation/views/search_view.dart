import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/search/presentation/views/widgets/search_field.dart';

import 'widgets/recent_search_secion.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Search', leadingIcon: false),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 32.0,
            ),
            SearchField(),
            SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: RecentSearchSection(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Search')
      //  AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   title: Row(
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.arrow_back),
      //         onPressed: () => Navigator.pop(context),
      //       ),
      //       const Expanded(
      //         child: Hero(
      //           tag: 'searchFieldHero',
      //           child: SearchTextField(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),,
      ,
      body: const SearchViewBody(),
    );
  }
}

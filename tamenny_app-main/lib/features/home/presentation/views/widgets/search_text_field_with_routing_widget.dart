import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/functions/create_animation_from_search_text_field.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/search_text_field.dart';

class SearchTextFieldWithRouting extends StatelessWidget {
  const SearchTextFieldWithRouting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(createRouteToSearch());
      },
      child: const AbsorbPointer(
        child: SearchTextField(),
      ),
    );
  }
}

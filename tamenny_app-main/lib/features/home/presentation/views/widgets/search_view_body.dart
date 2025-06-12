import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/search_text_field.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SearchTextField(),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: SvgPicture.asset(
                            Assets.imagesNoResultsIcon,
                            fit: BoxFit.cover,
                          ))),
                  const SizedBox(),
                  const Text(
                    'No results yet. Start typing...',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

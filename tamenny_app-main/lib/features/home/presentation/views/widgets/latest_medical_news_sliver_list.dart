import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/functions/get_dummy_article.dart';
import 'package:tamenny_app/core/widgets/custom_error_widget.dart';
import 'package:tamenny_app/features/home/presentation/manager/medical_news_cubit/medical_news_cubit.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/medical_article_item.dart';

class SliverMedicalArticlesList extends StatelessWidget {
  const SliverMedicalArticlesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalNewsCubit, MedicalNewsState>(
      builder: (context, state) {
        if (state is MedicalNewsSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return MedicalArticleItem(
                  article: state.articles[index],
                );
              },
              childCount: state.articles.length.clamp(0, 4),
            ),
          );
        } else if (state is MedicalNewsFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(errMessage: state.errMessage),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return MedicalArticleItem(
                    article: dummyArticles[index],
                  );
                },
                childCount: dummyArticles.length,
              ),
            ),
          );
        }
      },
    );
  }
}

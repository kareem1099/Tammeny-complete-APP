import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/domain/entites/article_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/medical_article_item.dart';

class LatestMedicalNewsSliverList extends StatelessWidget {
  const LatestMedicalNewsSliverList({super.key, required this.articles});
  final List<ArticleEntity> articles;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) => MedicalArticleItem(article: articles[index]),
          childCount: articles.length,
        ),
      ),
    );
  }
}

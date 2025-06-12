import 'package:flutter/material.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/home/domain/entites/article_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/latest_medical_news_view_body.dart';

class LatestMedicalNewsView extends StatelessWidget {
  const LatestMedicalNewsView({super.key, required this.articles});
  final List<ArticleEntity> articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Medical News'),
      body: CustomScrollView(
        slivers: [
          LatestMedicalNewsSliverList(articles: articles),
        ],
      ),
    );
  }
}

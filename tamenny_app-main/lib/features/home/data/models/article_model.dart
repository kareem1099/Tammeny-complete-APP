import 'package:tamenny_app/features/home/domain/entites/article_entity.dart';

class ArticleModel {
  String title;
  String link;
  String description;
  String content;
  String pubDate;
  String imageUrl;
  String creator;
  String sourceId;
  String sourceName;

  ArticleModel({
    required this.title,
    required this.link,
    required this.description,
    required this.content,
    required this.pubDate,
    required this.imageUrl,
    required this.creator,
    required this.sourceId,
    required this.sourceName,
  });

  ArticleEntity toEntity() => ArticleEntity(
    description: description,
    imageUrl: imageUrl,
    title: title,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    title: json['title'] ?? '',
    link: json['url'] ?? '',
    description: json['description'] ?? '',
    content: json['content'] ?? '',
    pubDate: json['publishedAt'] ?? '',
    imageUrl: json['urlToImage'] ?? '',
    creator: json['author'] ?? '',
    sourceId: json['source']?['id'] ?? '',
    sourceName: json['source']?['name'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'url': link,
    'description': description,
    'content': content,
    'publishedAt': pubDate,
    'urlToImage': imageUrl,
    'author': creator,
    'source': {
      'id': sourceId,
      'name': sourceName,
    },
  };
}

import 'Source.dart';

class Article {
  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;

  Article(
      {required this.source,
      this.author,
      required this.title,
      required this.description,
      required this.url,
      this.urlToImage,
      required this.publishedAt,
      required this.content});
}

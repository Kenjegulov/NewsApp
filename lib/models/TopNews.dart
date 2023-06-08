import 'Article.dart';

class TopNews {
  final String? status;
  final int? totalResults;
  final List<Article> articles;

  TopNews(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory TopNews.fromJson(Map<String, dynamic> json) {
    return TopNews(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            (json['articles']).map((e) => Article.fromJson(e))));
  }
}

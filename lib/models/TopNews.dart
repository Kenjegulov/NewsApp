import 'Article.dart';

class TopNews {
  final String? status;
  final int? totalResults;
  final Article articles;

  TopNews(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory TopNews.fromJson(Map<String, dynamic> json, int index) {
    return TopNews(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: Article.fromJson(
        json["articles"][index],
      ),
    );
  }
}

import 'Article.dart';

class TopNews {
  final String status;
  final int totalResults;
  final Article articles;

  TopNews(
      {required this.status,
      required this.totalResults,
      required this.articles});
}

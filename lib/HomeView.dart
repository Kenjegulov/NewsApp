import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson10/constants/MyApi.dart';
import 'package:flutter_lesson10/models/Article.dart';
import 'package:flutter_lesson10/models/Source.dart';
import 'package:flutter_lesson10/models/TopNews.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopNews? topNews;

  void newsData() async {
    Dio dio = Dio();
    final response = await dio.get(MyApi.myApiUrl);
    if (response.statusCode == 200) {
      setState(() {
        topNews = TopNews(
          status: response.data["status"],
          totalResults: response.data["totalResults"],
          articles: Article(
              source: Source(
                  id: response.data["articles"][0]["source"]["id"],
                  name: response.data["articles"][0]["source"]["name"]),
              author: response.data["articles"][0]["author"],
              title: response.data["articles"][0]["title"],
              description: response.data["articles"][0]["description"],
              url: response.data["articles"][0]["url"],
              urlToImage: response.data["articles"][0]["urlToImage"],
              publishedAt: response.data["articles"][0]["publishedAt"],
              content: response.data["articles"][0]["content"]),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    newsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tapshyrma 10')),
      ),
      body: Column(
        children: [
          Text("${topNews?.status}"),
          Text("${topNews?.totalResults}"),
          Text("${topNews?.articles.source.id}"),
          Text("${topNews?.articles.source.name}"),
          Text("${topNews?.articles.author}"),
          Text("${topNews?.articles.title}"),
          Text("${topNews?.articles.description}"),
          Text("${topNews?.articles.url}"),
          Image(image: NetworkImage("${topNews?.articles.urlToImage}")),
          Text("${topNews?.articles.publishedAt}"),
          Text("${topNews?.articles.content}"),
        ],
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson10/constants/MyApi.dart';
import 'package:flutter_lesson10/models/Article.dart';
import 'package:flutter_lesson10/models/Source.dart';
import 'package:flutter_lesson10/models/TopNews.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopNews? topNews;
  final http.Client client = http.Client();

  void newsData() async {
    // Dio dio = Dio();
    // final response = await dio.get(MyApi.myApiUrl);
    final Uri url = Uri.parse(MyApi.myApiUrl);
    final http.Response response = await client.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      // print(jsonResponse["articles"].length);
      setState(() {
        topNews = TopNews.fromJson(jsonResponse, 1);
        // topNews = TopNews(
        //   status: response.data["status"],
        //   totalResults: response.data["totalResults"],
        //   articles: Article(
        //       source: Source(
        //           id: response.data["articles"][1]["source"]["id"],
        //           name: response.data["articles"][1]["source"]["name"]),
        //       author: response.data["articles"][1]["author"],
        //       title: response.data["articles"][1]["title"],
        //       description: response.data["articles"][1]["description"],
        //       url: response.data["articles"][1]["url"],
        //       urlToImage: response.data["articles"][1]["urlToImage"],
        //       publishedAt: response.data["articles"][1]["publishedAt"],
        //       content: response.data["articles"][1]["content"]),
        // );
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
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse("${topNews?.articles.url}");
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text(
              "${topNews?.articles.title}",
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w100),
            ),
          ),
          Image(image: NetworkImage("${topNews?.articles.urlToImage}")),
          Text("${topNews?.articles.publishedAt}"),
          Text("${topNews?.articles.content}"),
        ],
      ),
    );
  }
}

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

  List<TopNews> jsonResponsies = [];

  int items = 0;

  void newsData() async {
    final Uri url = Uri.parse(MyApi.myApiUrl);
    final http.Response response = await client.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      items = jsonResponse["articles"].length;

      for (int i = 0; i < 2; i++) {
        setState(() {
          topNews = TopNews.fromJson(jsonResponse, i);
          print(topNews);
          print("Arsen");
          jsonResponsies.add(topNews!);
        });
      }
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
          title: Center(child: Text('Tapshyrma 10 $items')),
        ),
        body: ListView.builder(
          itemCount: items,
          prototypeItem: ListTile(
            title: Text("$items"),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Text(jsonResponsies[index].status),
                  Text("${jsonResponsies[index].totalResults}"),
                  Text("${jsonResponsies[index].articles.source.id}"),
                  Text(jsonResponsies[index].articles.source.name),
                  Text("${jsonResponsies[index].articles.author}"),
                  Text(jsonResponsies[index].articles.title),
                  Text(jsonResponsies[index].articles.description),
                  GestureDetector(
                    onTap: () async {
                      final Uri url =
                          Uri.parse(jsonResponsies[index].articles.url);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      jsonResponsies[index].articles.title,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Image(
                      image: NetworkImage(
                          "${jsonResponsies[index].articles.urlToImage}")),
                  Text(jsonResponsies[index].articles.publishedAt),
                  Text(jsonResponsies[index].articles.content),
                ],
              ),
            );
          },
        ));
  }
}

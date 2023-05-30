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

      for (int i = 0; i < items; i++) {
        setState(() {
          jsonResponsies.add(TopNews.fromJson(jsonResponse, i));
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
        title: const Text('News Aggregator'),
        backgroundColor: const Color(0xffFE5722),
      ),
      body: ListView.builder(
        itemCount: items,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        "${jsonResponsies[index].articles.urlToImage}"),
                    fit: BoxFit.cover,
                    width: 100.0,
                  ),
                  title: GestureDetector(
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
                      jsonResponsies[index].articles.source.name,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

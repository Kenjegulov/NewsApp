import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson10/models/TopNews.dart';
import 'package:flutter_lesson10/models/domain_countries.dart';
import 'package:flutter_lesson10/services/newsData.dart';

import 'moreInfo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopNews? topNews;
  Future<void> init([String? domain = 'us']) async {
    topNews = await NewsData().newsData(domain);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Aggregator'),
        actions: [
          PopupMenuButton<Country>(onSelected: (Country item) async {
            await init(item.domain);
          }, itemBuilder: (BuildContext context) {
            return countries
                .map((e) =>
                    PopupMenuItem<Country>(value: e, child: Text(e.name)))
                .toList();
          }),
        ],
        backgroundColor: const Color(0xffFE5722),
      ),
      body: ListView.builder(
        itemCount: topNews!.articles.length,
        itemBuilder: (context, index) {
          final news = topNews!.articles[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoreInfo(
                    article: news,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Card(
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CachedNetworkImage(
                          imageUrl: "${news.urlToImage}",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: Text(news.title.toString()),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 0,
                  endIndent: 0,
                  color: Color(0xff000000),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

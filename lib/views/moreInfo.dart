import 'package:flutter/material.dart';
import 'package:flutter_lesson10/models/Article.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text("More Info"),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(article.url.toString());
              },
              icon: article.title.toString().isNotEmpty
                  ? const Icon(Icons.share)
                  : const Icon(null))
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 40, right: 50, left: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    article.source.name.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  article.title.toString(),
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Image(image: NetworkImage(article.urlToImage.toString())),
              const SizedBox(height: 10),
              Text(article.content.toString()),
              const SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  final Uri url = Uri.parse(article.url.toString());
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: const Text('Ещё подробнее'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

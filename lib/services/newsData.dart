import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/MyApi.dart';
import '../models/TopNews.dart';

class NewsData {
  final http.Client client = http.Client();
  Future<TopNews?> newsData([String? domain]) async {
    final Uri url = Uri.parse(MyApi.myApiUrl(domain));
    final http.Response response = await client.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return TopNews.fromJson(data);
    }
    return null;
  }
}

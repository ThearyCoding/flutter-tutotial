import 'package:flutter_tutoial/models/news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  String baseUrl = "http://news.somee.com/api/news/get";

  Future<List<News>> fetchNews({int page = 1}) async {
    final url = Uri.parse('$baseUrl?page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> newsdata = json.decode(response.body);

      return newsdata.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Error fetching news');
    }
  }

  Future<News> fetchDetails(String link) async {
    final url = Uri.parse('http://news.somee.com/api/news/show?link=$link');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> newsdata = json.decode(response.body);

      return News.fromJson(newsdata[0]);
    } else {
      throw Exception('Error fetching detail news');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news_model.dart'; // Don't forget to import the http package

class NewsService {
  static const String baseUrl =
      'https://newsapi.org/v2/top-headlines?country=tr&apiKey=bb1af207d5af451ba18647049972a3dc';
    //refresh ekle
      //country=tr&apiKey=bb1af207d5af451ba18647049972a3dc from here, it is changeble to the other countries pages for instance,
      //that's why we should declare a variable for this part of url because user should be change this

  static Future<News> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return News.fromJson(jsonData);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}
